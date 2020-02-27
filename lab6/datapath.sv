module datapath(input logic Clk,
					 input logic Reset,
					 input logic LD_IR, LD_MDR, LD_MAR, LD_PC,
					 input logic [15:0] MDR_In,
					 output logic [15:0] IR_Out, 
					 output logic [15:0] MDR_Out, 
					 output logic [15:0] MAR_Out, 
					 output logic [15:0] PC_Out
					);
					
logic [15:0] pc_out, mar_out, mdr_out, ir_out;

IR IR_Reg(.Clk(Clk), .Reset(Reset), .LD_IR(LD_IR), .D(mdr_out), .Data_Out(ir_out));

MDR MDR_Reg(.Clk(Clk), .Reset(Reset), .LD_MDR(LD_MDR), .D(MDR_In), .Data_Out(mdr_out));

MAR MAR_Reg(.Clk(Clk), .Reset(Reset), .LD_MAR(LD_MAR), .D(pc_out), .Data_Out(mar_out));

PC PC_Reg(.Clk(Clk), .Reset(Reset), .LD_PC(LD_PC), .D(pc_out + 4'h0001), .Data_Out(pc_out));

endmodule
