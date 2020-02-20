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

register_unit reg_unit(
							.Clk(Clk),
							.Reset()
							);

control c_unit(
				.Clk(Clk),
				.Reset(),
				.Run(),
				.ClearA_LoadB(),
				.B(),
				.Clr_Ld(),
				.Shift(),
				.Add(),
				.Sub()
				);

carry_select_adder adder_unit();


HexDriver        HexAL (
                        .In0(A[3:0]),
                        .Out0(AhexL) );
HexDriver        HexBL (
                        .In0(B[3:0]),
                        .Out0(BhexL) );
HexDriver        HexAU (
                        .In0(A[6:3]),
                        .Out0(AhexU) );
HexDriver        HexBU (
                        .In0(B[6:3]),
                        .Out0(BhexU) );








endmodule