module MDR (input logic Clk,
			  input logic Reset,
			  input logic LD_MDR,
			  input logic [15:0] D,
			  output logic [15:0] Data_Out);

reg_16 mdr_reg(.Clk(Clk), .Reset(Reset), .Load(LD_MDR), .D(D), .Data_Out(Data_Out));

endmodule
