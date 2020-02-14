module carry_lookahead_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a CLA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	  
	logic G0, G4, G8, G12;
	logic P0, P4, P8, P12;
	  
	four_bit_CLA cla0(.x(A[3:0]), .y(B[3:0]), .cIn(0), .s(Sum[3:0]), .g(G0), .p(P0));
	four_bit_CLA cla1(.x(A[7:4]), .y(B[7:4]), .cIn(G0), .s(Sum[7:4]), .g(G4), .p(P4));
	four_bit_CLA cla2(.x(A[11:8]), .y(B[11:8]), .cIn(G4 | (G0&P4)), .s(Sum[11:8]), .g(G8), .p(P8));
	four_bit_CLA cla3(.x(A[15:12]), .y(B[15:12]), .cIn(G8 | (G4&P8) | (G0&P8&P4)), .s(Sum[15:12]), .g(G12), .p(P12));
	
	assign CO = G12 + (G8&P12) | (G4&P12&P8) | (G0&P12&P8&P4);
     
endmodule

module four_bit_CLA(
	input [3:0] x,
	input [3:0] y,
	input cIn,
	output logic [3:0] s,
	output logic g,
	output logic p
);

	logic g0, g1, g2, g3;
	logic p0, p1, p2, p3;

	full_adder_CLA fa0(.x(x[0]), .y(y[0]), .cIn(cIn), .s(s[0]), .g(g0), .p(p0));
	full_adder_CLA fa1(.x(x[1]), .y(y[1]), .cIn((cIn&p0) | g0), .s(s[1]), .g(g1), .p(p1));
	full_adder_CLA fa2(.x(x[2]), .y(y[2]), .cIn((cIn&p0&p1) | (g0&p1) | g1), .s(s[2]), .g(g2), .p(p2));
	full_adder_CLA fa3(.x(x[3]), .y(y[3]), .cIn((cIn&p0&p1&p2) | (g0&p1&p2) | (g1&p2) | g2), .s(s[3]), .g(g3), .p(p3));

	assign p = p0&p1&p2&p3;
	assign g = g3 | (g2&p3) | (g1&p3&p2) | (g0&p3&p2&p1);

endmodule
	
module full_adder_CLA(
	input x,
	input y,
	input cIn,
	output logic s,
	output logic g,
	output logic p
);

	assign s = x^y^cIn;
	assign g = x&y;
	assign p = x^y;

endmodule 