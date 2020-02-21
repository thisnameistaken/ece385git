module csa0(input [3:0] A, input [3:0] B, input cIn, output logic [3:0] out, output logic cout);

	four_bit_adder bruh(.x(A[3:0]), .y(B[3:0]), .cIn(0), .s(out), .cOut(cout));

	
endmodule