module calc(
	input logic[8:0] A,
	input logic[8:0] B,
	input logic opp,
	output logic[8:0] Ans
	//output logic Carry DONT NEED CARRY
);

	logic [8:0] Btemp;
	logic useless;
	
	
	always_comb
	begin
		Btemp = (B ^ {9{opp}});
	end

	
	adder useful(.A(A), .B(B), .Sum(Ans), .Carry(useless));



endmodule