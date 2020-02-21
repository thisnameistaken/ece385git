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
logic x1, x2, add, sub, shift, clr_A, a_out, b_out, clr, cOut;

assign Aval = A;
assign Bval = B;

register_unit reg_unit(
							.Clk(Clk),
							.Reset(Reset_SH), //Button
							.x1(x1),
							.x2(x2),
							.Add(add), 
							.Clr_Ld(clr),
							.Shift(shift),
							.ClearA(clr_A),
							.aout(a_out),
							.Ain(sum),
							.Bin(Din_S), //Switches
							.A_out(a_out),
							.B_out(b_out),
							.X_out(x2),
							.A(A),
							.B(B)
							);

control c_unit(
				.Clk(Clk),
				.Reset(Reset_SH), //Button
				.Run(Run_SH), //Button
				.ClearA_LoadB(ClrA_LdB), 
				.x_in(x2),
				.Bin(B),
				.Clr_Ld(clr),
				.Shift(shift),
				.Add(add),
				.Sub(sub),
				.X(x1),
				.ClearA(clr_A)
				);

carry_select_adder adder_unit(
									.A(A),
									.B(Din_S),
									.A9(A[7]),
									.B9(Din_S[7]),
									.Sum(sum),
									.cOut(cOut),
									.X(x1)
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


	  //Input synchronizers required for asynchronous inputs (in this case, from the switches)
	  //These are array module instantiations
	  //Note: S stands for SYNCHRONIZED, H stands for active HIGH
	  //Note: We can invert the levels inside the port assignments
	  sync button_sync[2:0] (Clk, {~Reset, ~ClearA_LoadB, ~Run}, {Reset_SH, ClrA_LdB, Run_SH});
	  sync Din_sync[7:0] (Clk, S, Din_S);

endmodule 