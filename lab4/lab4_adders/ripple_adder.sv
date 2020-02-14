module ripple_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a ripple adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	logic C0, C1, C2;
	
	four_bit_adder FA0(.x(A[3:0]), .y(B[3:0]), .cIn(0), .s(Sum[3:0]), .cOut(C0));
	four_bit_adder FA1(.x(A[7:4]), .y(B[7:4]), .cIn(C0), .s(Sum[7:4]), .cOut(C1));
	four_bit_adder FA2(.x(A[11:8]), .y(B[11:8]), .cIn(C1), .s(Sum[11:8]), .cOut(C2));
	four_bit_adder FA3(.x(A[15:12]), .y(B[15:12]), .cIn(C2), .s(Sum[15:12]), .cOut(CO));
     
endmodule

module four_bit_adder(
	input [3:0] x,
	input [3:0] y,
	input cIn,
	output logic [3:0] s,
	output logic cOut
);

	logic c0, c1, c2;

	full_adder fa0(.x(x[0]), .y(y[0]), .cIn(cIn), .s(s[0]), .cOut(c0));
	full_adder fa1(.x(x[1]), .y(y[1]), .cIn(c0), .s(s[1]), .cOut(c1));
	full_adder fa2(.x(x[2]), .y(y[2]), .cIn(c1), .s(s[2]), .cOut(c2));
	full_adder fa3(.x(x[3]), .y(y[3]), .cIn(c2), .s(s[3]), .cOut(cOut));

endmodule

module full_adder(
	input x,
	input y,
	input cIn,
	output logic s,
	output logic cOut
);

	assign s = x^y^cIn;
	assign cOut = (x&y) | (y&cIn) | (cIn&x);

endmodule 