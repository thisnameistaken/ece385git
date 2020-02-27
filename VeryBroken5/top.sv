module top
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

logic Reset_SH, ClrA_LdB, Run_SH;
logic [7:0] A, B, Din_S, sum;
logic add, sub, shift, clr_A, a_out, b_out, clr, cOut, xfromadd;

assign Aval = A;
assign Bval = B;

register_unit reg_unit(
							.Clk(Clk),
							.Reset(Reset_SH), //Button
							.x1(xfromadd),
							.Add(add), 
							.Sub(sub),
							.Clr_Ld(clr),
							.Shift(shift),
							.ClearA(clr_A),
							.aout(a_out),
							.Ain(sum),
							.Bin(Din_S), //Switches
							.A_out(a_out),
							.B_out(b_out),
							.X_out(X),
							.A(A),
							.B(B)
							);

							/*
							
reg_8 ReggieA(.Clk(Clk), 
				  .Reset(Reset_SH || clr_A), 
				  .Shift_In(X), 
				  .Load(add || sub), 
				  .D(sum[7:0]), 
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
						  .Reset(clr_A|| Reset_SH),
						  .Load(add || sub),
						  .D(xfromadd),
						  .Data_Out(X)
						  );	
							
	*/						
							
control c_unit(
				.Clk(Clk),
				.Reset(Reset_SH), //Button
				.Run(Run_SH), //Button
				.ClearA_LoadB(ClrA_LdB), 
				.Bin(B),
				.Clr_Ld(clr),
				.Shift(shift),
				.Add(add),
				.Sub(sub),
				.ClearA(clr_A)
				);

carry_select_addermod       adder_unit(
									.A(A),
									.B(Din_S),
									.A9(A[7]),
									.B9(Din_S[7]),
									.sub(sub),
									.Sum(sum),
									.cOut(cOut),
									.X(xfromadd)
									);

									
/*reg_8  reg_A (.Clk(Clk), .Reset(ClearA || Reset || Clr_Ld), .Shift_In(X),
				  .Load(Add),.Shift(shift), .D(sum[7:0]), .Shift_Out(a_out), .Data_Out(A));								

reg_8  reg_B (.Clk(Clk), .Shift_In(aout), .Load(Clr_Ld), .Shift(shift), .D(Din_S), .Shift_Out(b_out), .Data_Out(B));				  

reg_1 reg_X(.Clk(Clk),.Reset(ClearA || Reset || Clr_Ld), .Load(Add), .D(xfromadd), .Data_Out(X));
*/
/*Subber    sub_unit(
						.A(A),
						.B(Din_S),
						.A9(A[7]),
						.B9(Din_S[7]),
						.Ans(sum),
						.cOut(cOut),
						.X(x1)
						


						);*/

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


	  //Input synchronizers required for asynchronous inputs (in this case, from the switches)
	  //These are array module instantiations
	  //Note: S stands for SYNCHRONIZED, H stands for active HIGH
	  //Note: We can invert the levels inside the port assignments
	  sync button_sync[2:0] (Clk, {~Reset, ~ClearA_LoadB, ~Run}, {Reset_SH, ClrA_LdB, Run_SH});
	  sync Din_sync[7:0] (Clk, S, Din_S);

endmodule 