module datapath(input logic Clk,
					 input logic Reset,
					 input logic LD_IR, LD_MDR, LD_MAR, LD_PC, GatePC, GateMDR, GateALU, GateMARMUX,
					 input logic [1:0] PCMUX,
					 input logic [15:0] MDR_In,
					 output logic [15:0] IR_Out, 
					 output logic [15:0] MDR_Out, 
					 output logic [15:0] MAR_Out, 
					 output logic [15:0] PC_Out
					);

//Internal logic
logic [15:0] pc_in; //Inputs for registers
logic [15:0] pc_out, mar_out, mdr_out, ir_out, adder_out, alu_out; //Outputs of registers
logic [15:0] data_bus; //Data on bus
logic [1:0] gate_select; 

assign gate_select[1] = ~GatePC & ~GateMDR; //Logic for internal tri-state buffers
assign gate_select[0] = ~GatePC & ~GateALU;

assign IR_Out = ir_out; //Assign outputs
assign MDR_Out = mdr_out;
assign MAR_Out = mar_out;
assign PC_Out = pc_out;

//Registers in datapath
IR IR_Reg(.Clk(Clk), .Reset(Reset), .LD_IR(LD_IR), .D(data_bus), .Data_Out(ir_out));

MDR MDR_Reg(.Clk(Clk), .Reset(Reset), .LD_MDR(LD_MDR), .D(MDR_In), .Data_Out(mdr_out));

MAR MAR_Reg(.Clk(Clk), .Reset(Reset), .LD_MAR(LD_MAR), .D(data_bus), .Data_Out(mar_out));

PC PC_Reg(.Clk(Clk), .Reset(Reset), .LD_PC(LD_PC), .D(pc_in), .Data_Out(pc_out));

//Muxes in datapath
threemux_16bit PC_MUX(.A(pc_out + 16'h01), .B(data_bus), .C(adder_out), .Select(PCMUX), .Out(pc_in));


//Mux for Gate select replacing internal tri-state buffers
fourmux_16bit gate_Select_MUX(.A(pc_out), .B(mdr_out), .C(alu_out), .D(adder_out), .Select(gate_select), .Out(data_bus));


endmodule
