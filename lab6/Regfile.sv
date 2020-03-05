module Regfile(input logic Clk,
					input logic Reset,
					input logic LD_REG,
					input logic [2:0] DR_In, SR1_In, SR2_In,
					input logic [15:0] data_bus,
					output logic [15:0] SR1_Out, SR2_Out);
				
logic LD_r0, LD_r1, LD_r2, LD_r3, LD_r4, LD_r5, LD_r6, LD_r7;
logic [15:0] r0_Out, r1_Out, r2_Out, r3_Out, r4_Out, r5_Out, r6_Out, r7_Out;
				
//Registers R0 to R7
reg_16 r0(.Clk(Clk), .Reset(Reset), .Load(LD_r0), .D(data_bus), .Data_Out(r0_Out));
reg_16 r1(.Clk(Clk), .Reset(Reset), .Load(LD_r1), .D(data_bus), .Data_Out(r1_Out));
reg_16 r2(.Clk(Clk), .Reset(Reset), .Load(LD_r2), .D(data_bus), .Data_Out(r2_Out));
reg_16 r3(.Clk(Clk), .Reset(Reset), .Load(LD_r3), .D(data_bus), .Data_Out(r3_Out));
reg_16 r4(.Clk(Clk), .Reset(Reset), .Load(LD_r4), .D(data_bus), .Data_Out(r4_Out));
reg_16 r5(.Clk(Clk), .Reset(Reset), .Load(LD_r5), .D(data_bus), .Data_Out(r5_Out));
reg_16 r6(.Clk(Clk), .Reset(Reset), .Load(LD_r6), .D(data_bus), .Data_Out(r6_Out));
reg_16 r7(.Clk(Clk), .Reset(Reset), .Load(LD_r7), .D(data_bus), .Data_Out(r7_Out));

//MUX to choose load signals for registers
always_comb 
	begin
		LD_r0 = 1'b0; 
		LD_r1 = 1'b0;
		LD_r2 = 1'b0;
		LD_r3 = 1'b0;
		LD_r4 = 1'b0;
		LD_r5 = 1'b0;
		LD_r6 = 1'b0;
		LD_r7 = 1'b0;
		case(DR_In)
		3'b000 : LD_r0 = 1'b1;
		3'b001 : LD_r1 = 1'b1;
		3'b010 : LD_r2 = 1'b1;
		3'b011 : LD_r3 = 1'b1;
		3'b100 : LD_r4 = 1'b1;
		3'b101 : LD_r5 = 1'b1;
		3'b110 : LD_r6 = 1'b1;
		3'b111 : LD_r7 = 1'b1;
		endcase
	end
endmodule 

//MUXs to choose data out signals for sr1out and sr2out
/*always_comb
	begin
		case(SR1_In)
		default : */