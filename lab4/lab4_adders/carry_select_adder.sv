module carry_select_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a carry select.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	  
	  logic C0, C1, C2;
	  csa0 FA0(.A(A[3:0]), .B(B[3:0]), .cIn(0), .o(Sum[3:0]), .cout(C0));
	  csa FA1(.A(A[7:4]), .B(B[7:4]), .cIn(C0), .out(Sum[7:4]), .cout(C1));
	  csa FA2(.A(A[11:8]), .B(B[11:8]), .cIn(C1), .out(Sum[11:8]), .cout(C2));
	  csa FA3(.A(A[15:12]), .B(B[15:12]), .cIn(C2), .out(Sum[15:12]), .cout(CO));
	  
	  
     
	  
	  
	  
endmodule

module csa0(input [3:0] A, input [3:0] B, input cIn, output logic [3:0] o, output logic cout);



	
	logic c0, c1, c2;
	full_adder_csa fa0(.x(A[0]), .y(B[0]), .cIn(cIn), .s(o[0]), .cOut(c0));
	full_adder_csa fa1(.x(A[1]), .y(B[1]), .cIn(c0), .s(o[1]), .cOut(c1));
	full_adder_csa fa2(.x(A[2]), .y(B[2]), .cIn(c1), .s(o[2]), .cOut(c2));
	full_adder_csa fa3(.x(A[3]), .y(B[3]), .cIn(c2), .s(o[3]), .cOut(cout));
endmodule

module csa(input [3:0] A, input [3:0] B, input cIn, output logic [3:0] out, output logic cout);
	
	
	//carry0
	
	logic c0, c1, c2, c6;
	logic [3:0] o1;
	logic zer = 0;
	
	full_adder_csa fa0(.x(A[0]), .y(B[0]), .cIn(0), .s(o1[0]), .cOut(c0));
	full_adder_csa fa1(.x(A[1]), .y(B[1]), .cIn(c0), .s(o1[1]), .cOut(c1));
	full_adder_csa fa2(.x(A[2]), .y(B[2]), .cIn(c1), .s(o1[2]), .cOut(c2));
	full_adder_csa fa3(.x(A[3]), .y(B[3]), .cIn(c2), .s(o1[3]), .cOut(c6));
	
	
	//carry1
	logic c3, c4, c5, c7;
	logic [3:0] o2;
	
	logic one = 1;
	full_adder_csa fa4(.x(A[0]), .y(B[0]), .cIn(1), .s(o2[0]), .cOut(c3));
	full_adder_csa fa5(.x(A[1]), .y(B[1]), .cIn(c3), .s(o2[1]), .cOut(c4));
	full_adder_csa fa6(.x(A[2]), .y(B[2]), .cIn(c4), .s(o2[2]), .cOut(c5));
	full_adder_csa fa7(.x(A[3]), .y(B[3]), .cIn(c5), .s(o2[3]), .cOut(c7));
	
	always_comb
	begin
	if(cIn == 0) begin
		 out = o1;
		 cout = c6;
	end
	else begin
		 out = o2;
		 cout = c7;
	end
	end
	//this syntax sucks so much ass
	
	
	
endmodule



module full_adder_csa(
	input x,
	input y,
	input cIn,
	output logic s,
	output logic cOut
);

	assign s = x^y^cIn;
	assign cOut = (x&y) | (y&cIn) | (cIn&x);

endmodule 

/*module four_bit_adder_csa(
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

endmodule*/





