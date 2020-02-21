module adder
(
    input   logic[7:0]     A,
    input   logic[7:0]     B,
	 input logic A9,
	 input logic B9,
    output  logic[8:0]     Sum,
    output  logic          Carry
);

    /* TODO
     *
     * Insert code here to implement a carry select.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	  
	  logic C0, C1;
	  csa0 FA0(.A(A[3:0]), .B(B[3:0]), .cIn(0), .out(Sum[3:0]), .cout(C0));
	  csa FA1(.A(A[7:4]), .B(B[7:4]), .cIn(C0), .out(Sum[7:4]), .cout(C1));
	  full_adder FA2(.x(A9), .y(B9), .cIn(c1), .s(Sum[8]), .cOut(Carry));
	  
	  
	    
endmodule