module carry_select_adder
(
    input   logic[8:0]     A,
    input   logic[8:0]     B,
    output  logic[7:0]     Sum,
    output  logic          cOut
	 output logic				X
);

    /* TODO
     *
     * Insert code here to implement a carry select.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	  
	  logic C0, C1;
	  csa0 FA0(.A(A[3:0]), .B(B[3:0]), .cIn(0), .out(Sum[3:0]), .cout(C0));
	  csa FA1(.A(A[7:4]), .B(B[7:4]), .cIn(C0), .out(Sum[7:4]), .cout(C1));
	  full_adder FA2(.x(A[8]), .y(B[8]), .cIn(c1), .s(X), .cOut(cOut));
	  
	  
	    
endmodule




module csa0(input [3:0] A, input [3:0] B, input cIn, output logic [3:0] out, output logic cout);

	four_bit_adder bruh(.x(A[3:0]), .y(B[3:0]), .cIn(0), .s(out), .cOut(cout));

	
endmodule


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
