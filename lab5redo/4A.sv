module four_bit_adder(
	input [3:0] x,
	input [3:0] y,
	input cIn,
	output logic [3:0] s,
	output logic cOut
);

	logic c0, c1, c2;

	fulladder fa0(.x(x[0]), .y(y[0]), .cIn(cIn), .s(s[0]), .cOut(c0));
	fulladder fa1(.x(x[1]), .y(y[1]), .cIn(c0), .s(s[1]), .cOut(c1));
	fulladder fa2(.x(x[2]), .y(y[2]), .cIn(c1), .s(s[2]), .cOut(c2));
	fulladder fa3(.x(x[3]), .y(y[3]), .cIn(c2), .s(s[3]), .cOut(cOut));

endmodule