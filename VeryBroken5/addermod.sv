module carry_select_addermod
(
    input   logic[8:0]     A,
    input   logic[8:0]     B,
	 input   logic 			A9, B9, sub,
    output  logic[7:0]     Sum,
    output  logic          cOut,
	 output logic				X
);

    /* TODO
     *
     * Insert code here to implement a carry select.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	  
	  logic [7:0] Btemp;
	  
	  logic b9tmp;
	  
	  
	  always_comb
		begin
		Btemp = (B ^ {8{sub}});
		b9tmp = Btemp[7];
		end
		
		
	  
	  logic C0, C1;
	  csa0 FA0(.A(A[3:0]), .B(Btemp[3:0]), .cIn(0), .out(Sum[3:0]), .cout(C0));
	  csa FA1(.A(A[7:4]), .B(Btemp[7:4]), .cIn(C0), .out(Sum[7:4]), .cout(C1));
	  full_adder FA2(.x(A9), .y(b9tmp), .cIn(c1), .s(X), .cOut(cOut));
	  
	  
	    
endmodule




