module MAR (input logic Clk,
			  input logic Reset,
			  input logic LD_MAR,
			  input logic [15:0] D,
			  output logic [15:0] Data_Out);

reg_16 mar_reg(.Clk(Clk), .Reset(Reset), .Load(LD_MAR), .D(D), .Data_Out(Data_Out));

endmodule