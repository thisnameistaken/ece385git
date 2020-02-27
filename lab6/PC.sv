module PC (input logic Clk,
			  input logic Reset,
			  input logic LD_PC,
			  input logic [15:0] D,
			  output logic [15:0] Data_Out);

reg_16 pc_reg(.Clk(Clk), .Reset(Reset), .Load(LD_PC), .D(D), .Data_Out(Data_Out));

endmodule
