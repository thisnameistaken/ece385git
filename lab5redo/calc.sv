module calc(
	input logic[7:0] A,
	input logic[7:0] B,
	input logic opp,
	output logic[8:0] Ans
	//output logic Carry DONT NEED CARRY
);

	logic [7:0] Btemp;
	logic useless;
	logic extA;
	logic extB;
	
	
	always_comb
	begin
		Btemp = (B ^ {9{opp}});
	end

	
	adder useful(.A(A), .B(B), .A9(A[7]), .B9(Btemp[7]), .Sum(Ans), .Carry(useless));



endmodule