module IR (input logic Clk,
			  input logic Reset,
			  input logic LD_IR,
			  input logic [15:0] D,
			  output logic [15:0] Data_Out);

reg_16 ir_reg(.Clk(Clk), .Reset(Reset), .Load(LD_IR), .D(D), .Data_Out(Data_Out));

endmodule
