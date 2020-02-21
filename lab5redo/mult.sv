module mult
(
    input   logic           Clock,        // 50MHz clock is only used to get timing estimate data
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



logic [7:0] A;
logic [7:0] B;
logic [7:0] Sin;


logic [8:0] Sum;
logic [8:0] SextA;



sex extA(.in(A), .out(SextA));















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