module mult
(
    input   logic           Clk,        // 50MHz clock is only used to get timing estimate data
    input   logic           Reset,      // From push-button 0.  Remember the button is active low (0 when pressed)
    input   logic           ClearA_LoadB,      // From push-button 1
    input   logic           Run,        // From push-button 3.
    input   logic[7:0]      S,         // From slider switches
    
    // all outputs are registered
           
    output  logic[6:0]      AhexU,      
    output  logic[6:0]      AhexL,
    output  logic[6:0]      BhexU,
    output  logic[6:0]      BhexL,
    output  logic[7:0]      Aval,
    output  logic[7:0]      Bval,
	 output  logic           X
);

logic Reset_SH, ClrA_LdB, Run_SH; //buttons from sync


logic add, sub, shift, a_out, b_out, clr;

logic [7:0] A;
logic [7:0] B;
logic [7:0] Din_S;

logic [8:0] Sum;
//logic [8:0] SextA;


assign Aval = A;
assign Bval = B;


/*
sex extA(.in(A), .out(SextA)); // sign extend A
sex extS(.in(Din_S), .out(SextS)); // sign extend S
*/



adder domath(.A(A), .B(Din_S), .opp(sub), .Ans(Sum)); //2s complement add subtract


control doyourjob(.Clk(Clk), 
						.Reset(Reset_SH), 
						.Run(Run_SH), 
						.ClearA_LoadB(ClrA_LdB), 
						.Bin(B), 
						.Clr_Ld(clr), 
						.Shift(shift),
						.Add(add),
						.Sub(sub)
						);

						
						
						
						

reg_8 ReggieA(.Clk(Clk), 
				  .Reset(Reset_SH || clr), 
				  .Shift_In(X), 
				  .Load(add || sub), 
				  .D(Sum[7:0]), 
				  .Shift_Out(a_out),
				  .Data_Out(A)
				  );
				  



reg_8 ReggieBruh(.Clk(Clk), 
				  .Reset(Reset_SH), 
				  .Shift_In(a_out), 
				  .Load(clr), 
				  .D(Din_S), 
				  .Shift_Out(b_out),
				  .Data_Out(B)
				  );





reg_1 XGamesRedBull(.Clk(Clk), 
						  .Reset(clr|| Reset_SH),
						  .Load(add || sub),
						  .D(Sum[8]),
						  .Data_Out(X)
						  );						
						
						
						
						
						
						
						

HexDriver        HexAL (
                        .In0(A[3:0]),
                        .Out0(AhexL) );
HexDriver        HexBL (
                        .In0(B[3:0]),
                        .Out0(BhexL) );
HexDriver        HexAU (
                        .In0(A[7:4]),
                        .Out0(AhexU) );
HexDriver        HexBU (
                        .In0(B[7:4]),
                        .Out0(BhexU) );
								
								
								

sync button_sync[2:0] (Clk, {~Reset, ~ClearA_LoadB, ~Run}, {Reset_SH, ClrA_LdB, Run_SH});
sync Din_sync[7:0] (Clk, S, Din_S);



endmodule 