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