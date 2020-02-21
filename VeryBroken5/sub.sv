module AddSub
(
    input   logic[7:0]     A,
    input   logic[7:0]     B,
	 input   logic 			A9, B9,
	 input logic Add, Sub,
    output  logic[7:0]     Ans,
    output  logic          cOut,
	 output logic				X
);
	  logic [8:0] Btemp;
	  logic [8:0] Bfinal;
	  logic useless;
always_comb
begin
		
		if(Add == 0 && Sub == 1) begin
			Btemp[7:0] = ~B;
			Btemp[8] = ~B9;
			
			
		end
		
		else begin
			Bfinal[7:0] = B;
			Bfinal[8] = B9;
	   end

end
	  
	  carry_select_adderunmod adder(
									.A(A),
									.B(Bfinal[7:0]),
									.A9(A9),
									.B9(Bfinal[8]),
									.Sum(Ans),
									.cOut(cOut)
									);
always_comb begin
		X = Ans[7];
end

endmodule