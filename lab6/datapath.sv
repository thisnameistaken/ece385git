module datapath(input logic Clk,
					 input logic Reset,
					 input logic LD_IR, LD_MDR, LD_MAR, LD_PC, LD_REG, LD_CC, LD_BEN, 
					 input logic GatePC, GateMDR, GateALU, GateMARMUX, MIO_EN, ADDR1MUX, SR1MUX, SR2MUX, DRMUX,
					 input logic [1:0] PCMUX, ADDR2MUX, ALUK,
					 input logic [15:0] MDR_In,
					 output logic [15:0] IR_Out, 
					 output logic [15:0] MDR_Out, 
					 output logic [15:0] MAR_Out, 
					 output logic [15:0] PC_Out,
					 output logic BEN
					);

//Internal logic
logic [15:0] pc_in, mdr_in, adder_1, adder_2; //Inputs for registers
logic [15:0] sext5, sext6, sext9, sext11; //Sign Extend bits
logic [15:0] pc_out, mar_out, mdr_out, ir_out, adder_out, alu_out; //Outputs of registers
logic [15:0] data_bus; //Data on bus
logic [1:0] gate_select; //Buffer select for data_bus
logic [2:0] SR1_In, SR2_In, DR_In;
logic [15:0] SR1_Out, SR2_Out, SR2MUX_Out;

assign gate_select[1] = ~GatePC & ~GateMDR; //Logic for internal tri-state buffers
assign gate_select[0] = ~GatePC & ~GateALU; 

assign IR_Out = ir_out; //Assign outputs
assign MDR_Out = mdr_out;
assign MAR_Out = mar_out;
assign PC_Out = pc_out;

//Registers in datapath
IR IR_Reg(.Clk(Clk), .Reset(Reset), .LD_IR(LD_IR), .D(data_bus), .Data_Out(ir_out));

MDR MDR_Reg(.Clk(Clk), .Reset(Reset), .LD_MDR(LD_MDR), .D(mdr_in), .Data_Out(mdr_out));

MAR MAR_Reg(.Clk(Clk), .Reset(Reset), .LD_MAR(LD_MAR), .D(data_bus), .Data_Out(mar_out));

PC PC_Reg(.Clk(Clk), .Reset(Reset), .LD_PC(LD_PC), .D(pc_in), .Data_Out(pc_out));

//Muxes in datapath
threemux_16bit PC_MUX(.A(pc_out + 16'h01), .B(data_bus), .C(adder_out), .Select(PCMUX), .Out(pc_in)); //PCMUX


twomux_16bit ADDR1_MUX(.A(pc_out), .B(SR1_Out), .Select(ADDR1MUX), .Out(adder_1)); //ADDR1MUX

fourmux_16bit ADDR2_MUX(.A(16'h0), .B(sext6), .C(sext9), .D(sext11), .Select(ADDR2MUX), .Out(adder_2)); //ADDR2MUX


twomux_3bit DR_MUX(.A(ir_out[11:9]), .B(3'b111), .Select(DRMUX), .Out(DR_In)); //DRMUX

twomux_3bit SR1_MUX(.A(ir_out[11:9]), .B(ir_out[8:6]), .Select(SR1MUX), .Out(SR1_In)); //SR1MUX

twomux_16bit SR2_MUX(.A(SR2_Out), .B(sext5), .Select(SR2MUX), .Out(SR2MUX_Out)); //SR2MUX


twomux_16bit MIO_MUX(.A(data_bus), .B(MDR_In), .Select(MIO_EN), .Out(mdr_in)); //MIOEN MUX

//SEXTS
sextfive SEXT5(.in(ir_out[4:0]), .out(sext5));

sextsix SEXT6(.in(ir_out[5:0]), .out(sext6));

sextnine SEXT9(.in(ir_out[8:0]), .out(sext9));

sexteleven SEXT11(.in(ir_out[10:0]), .out(sext11));

//ADDER for ADDR1 and ADDR2
assign adder_out = adder_1 + adder_2;

//Register File
Regfile registers(.Clk(Clk), .Reset(Reset), .LD_REG(LD_REG), .DR_In(DR_In), .SR1_In(SR1_In), .SR2_In(IR[2:0]), .data_bus(data_bus),
.SR1_Out(SR1_Out), .SR2_Out(SR2_Out));

//NZP Logic
NZPReg nzp_reg(.Clk(Clk), .Reset(Reset), .nzp(ir_out[11:9]), .LD_CC(LD_CC), .LD_BEN(LD_BEN), .data_bus(data_bus), .BEnable(BEN));

//ALU
ALU alu(.A(SR1_Out), .B(SR2MUX_Out), .ALUK(ALUK), .Out(alu_out));

//Mux for Gate select replacing internal tri-state buffers
fourmux_16bit gate_Select_MUX(.A(pc_out), .B(mdr_out), .C(alu_out), .D(adder_out), .Select(gate_select), .Out(data_bus));

endmodule
