module csa(input [3:0] A, input [3:0] B, input cIn, output logic [3:0] out, output logic cout);
	
	
	//carry0
	
	logic c0;
	logic [3:0] o0;
	
	four_bit_adder FA0(.x(A[3:0]), .y(B[3:0]), .cIn(0), .s(o0), .cOut(c0));
	
	
	
	
	//carry1
	logic c1;
	logic [3:0] o2;
	
	four_bit_adder FA1(.x(A[3:0]), .y(B[3:0]), .cIn(0), .s(o1), .cOut(c1));
	
	
	
	always_comb
	begin
	if(cIn == 0) begin
		 out = o0;
		 cout = c0;
	end
	else begin
		 out = o1;
		 cout = c1;
	end
	end
	
	
	
endmodule