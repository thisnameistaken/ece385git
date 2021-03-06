//------------------------------------------------------------------------------
// Company:          UIUC ECE Dept.
// Engineer:         Stephen Kempf
//
// Create Date:    17:44:03 10/08/06
// Design Name:    ECE 385 Lab 6 Given Code - Incomplete ISDU
// Module Name:    ISDU - Behavioral
//
// Comments:
//    Revised 03-22-2007
//    Spring 2007 Distribution
//    Revised 07-26-2013
//    Spring 2015 Distribution
//    Revised 02-13-2017
//    Spring 2017 Distribution
//------------------------------------------------------------------------------


module ISDU (   input logic         Clk, 
									Reset,
									Run,
									Continue,
									
				input logic[3:0]    Opcode, 
				input logic         IR_5,
				input logic         IR_11,
				input logic         BEN,
				  
				output logic        LD_MAR,
									LD_MDR,
									LD_IR,
									LD_BEN,
									LD_CC,
									LD_REG,
									LD_PC,
									LD_LED, // for PAUSE instruction
									
				output logic        GatePC,
									GateMDR,
									GateALU,
									GateMARMUX,
									
				output logic [1:0]  PCMUX,
				output logic        DRMUX,
									SR1MUX,
									SR2MUX,
									ADDR1MUX,
				output logic [1:0]  ADDR2MUX,
									ALUK,
				  
				output logic        Mem_CE,
									Mem_UB,
									Mem_LB,
									Mem_OE,
									Mem_WE
				);

	enum logic [5:0] {  Halted, 
						/*PauseIR1, 
						PauseIR2, */
						S_18, 
						S_33_1, 
						S_33_2, 
						S_35, 
						S_32, 
						S_00,
						S_01,
						S_05,
						S_09,
						S_12,
						S_04,
						S_06,
						S_07,
						S_13,
						JSRPT2, // second step JSR
						BRANCHPASS, // BEN enabled and change PC
						LDRPT2, // LDR Memory (waiting)
						LDRPT3, // LDR Memory
						LDRPT4, // LDR 3rd Step
						STRPT2, // STR 2nd Step
						STRPT3, // STR Memory (waiting)
						STRPT4, // STR Memory
						PAUSEPT2 // 2nd part of pause state
						}   State, Next_state;   // Internal state logic
		
	always_ff @ (posedge Clk)
	begin
		if (Reset) 
			State <= Halted;
		else 
			State <= Next_state;
	end
   
	always_comb
	begin 
		// Default next state is staying at current state
		Next_state = State;
		
		// Default controls signal values
		LD_MAR = 1'b0;
		LD_MDR = 1'b0;
		LD_IR = 1'b0;
		LD_BEN = 1'b0;
		LD_CC = 1'b0;
		LD_REG = 1'b0;
		LD_PC = 1'b0;
		LD_LED = 1'b0;
		 
		GatePC = 1'b0;
		GateMDR = 1'b0;
		GateALU = 1'b0;
		GateMARMUX = 1'b0;
		 
		ALUK = 2'b00;
		 
		PCMUX = 2'b00;
		DRMUX = 1'b0;
		SR1MUX = 1'b0;
		SR2MUX = 1'b0;
		ADDR1MUX = 1'b0;
		ADDR2MUX = 2'b00;
		 
		Mem_OE = 1'b1;
		Mem_WE = 1'b1;
	
		// Assign next state
		unique case (State)
			Halted : 
				if (Run) 
					Next_state = S_18;                      
			S_18 : 
				Next_state = S_33_1;
			// Any states involving SRAM require more than one clock cycles.
			// The exact number will be discussed in lecture.
			S_33_1 : 
				Next_state = S_33_2;
			S_33_2 : 
				Next_state = S_35;
			S_35 : 
				Next_state = S_32;
			// PauseIR1 and PauseIR2 are only for Week 1 such that TAs can see 
			// the values in IR.
			/*PauseIR1 : 
				if (~Continue) 
					Next_state = PauseIR1;
				else 
					Next_state = PauseIR2;
			PauseIR2 : 
				if (Continue) 
					Next_state = PauseIR2;
				else 
					Next_state = S_18;*/
			S_32 : 
				case (Opcode)
					4'b0000 :
						Next_state = S_00; //BRANCH
					4'b0001 : 
						Next_state = S_01; //ADD
					4'b0101 : 
						Next_state = S_05; //AND
					4'b1001 : 
						Next_state = S_09; //NOT
					4'b1100 : 
						Next_state = S_12; //JMP (JUMP)
					4'b0100 : 
						Next_state = S_04; //JSR (JUMP SAVE REGISTER)
					4'b0110 : 
						Next_state = S_06; //LDR (LOAD REGISTER)
					4'b0111 : 
						Next_state = S_07; //STR (STORE)
					4'b1101 : 
						Next_state = S_13; //PAUSE

					// You need to finish the rest of opcodes.....

					default : 
						Next_state = S_18;
				endcase
			S_00 : 
				if (BEN) //Branch does dfferent things depending on BEN
					Next_state = BRANCHPASS;
				else 
					Next_state = S_18;
			BRANCHPASS :
				Next_state = S_18;	

			S_01 : //add top choosing
			
				Next_state = S_18;
				
			/*
				if (IR_5) 
					Next_state = ADDi;
				else 
					Next_state = ADDn;
			ADDi : 
				Next_state = S_18;
			ADDn : 
				Next_state = S_18; */

			S_05 : //AND top choosing
				Next_state = S_18;
			
			/*	if (IR_5) 
					Next_state = ANDi;
				else 
					Next_state = ANDn;
			ANDi : 
				Next_state = S_18;
			ANDn : 
				Next_state = S_18; */

			S_09 : //NOT state only needs one state
				Next_state = S_18;

			S_12 : //JMP only needs one state
				Next_state = S_18;

			S_04 : //JSR Needs two states,
				Next_state = JSRPT2;
			JSRPT2 :
				Next_state = S_18;

			S_06 : //LDR -> Requires several states to complete process
				Next_state = LDRPT2;
			LDRPT2 : 
				Next_state = LDRPT3;
			LDRPT3 :
				Next_state = LDRPT4;
			LDRPT4 :
				Next_state = S_18;

			S_07 : //STR -> Requires several states to complete process
				Next_state = STRPT2;
			STRPT2 : 
				Next_state = STRPT3;
			STRPT3 :
				Next_state = STRPT4;
			STRPT4 : 
				Next_state = S_18;

			S_13 : //Pause, p much same as pauseIR 
				if (~Continue) 
					Next_state = S_13;
				else 
					Next_state = PAUSEPT2;
			PAUSEPT2 : 
				if (Continue) 
					Next_state = PAUSEPT2;
				else 
					Next_state = S_18;

			// You need to finish the rest of states..... on it boss

			default : ;

		endcase
		
		// Assign control signals based on current state
		case (State)
			Halted: ;
			S_18 : 
				begin 
					GatePC = 1'b1;
					LD_MAR = 1'b1;
					PCMUX = 2'b00;
					LD_PC = 1'b1;
				end
			S_33_1 : 
				Mem_OE = 1'b0;
			S_33_2 : 
				begin 
					Mem_OE = 1'b0;
					LD_MDR = 1'b1;
				end
			S_35 : 
				begin 
					GateMDR = 1'b1;
					LD_IR = 1'b1;
				end
			S_32 : 
				LD_BEN = 1'b1;
			S_13: 
				LD_LED = 1'b1; //Pause 1
			PAUSEPT2: 
				LD_LED = 1'b1; //Pause 2
			BRANCHPASS : //S_22
				begin
					ADDR1MUX = 1'b0;
					ADDR2MUX = 2'b10;
					PCMUX = 2'b10;
					LD_PC = 1'b1;
				end
			S_01 : //ADD
				begin
					SR1MUX = 1'b1;
					SR2MUX = IR_5;
					ALUK = 2'b00;
					GateALU = 1'b1;
					DRMUX = 1'b0;
					LD_REG = 1'b1;
					LD_CC = 1'b1;
				end
			S_05 : //AND
				begin
					SR1MUX = 1'b1;
					SR2MUX = IR_5;
					ALUK = 2'b01;
					GateALU = 1'b1;
					DRMUX = 1'b0;					
					LD_REG = 1'b1;
					LD_CC = 1'b1;
				end
			S_09 : //NOT/XOR
				begin
					SR1MUX = 1'b1;
					ALUK = 2'b10;
					GateALU = 1'b1;
					DRMUX = 1'b0;
					LD_REG = 1'b1;
					LD_CC = 1'b1;
				end
			S_12 : //JMP
				begin
					SR1MUX = 1'b1;
					ADDR1MUX = 1'b1;
					ADDR2MUX = 2'b00;
					PCMUX = 2'b10;
					LD_PC = 1'b1;
				end
			S_04 : //JSR
				begin
					GatePC = 1'b1;
					DRMUX = 1'b1;
					LD_REG = 1'b1;
				end
			JSRPT2 : //S_21
				begin
					ADDR1MUX = 1'b0;
					ADDR2MUX = 2'b11;
					PCMUX = 2'b10;
					LD_PC = 1'b1;
				end
			S_06 : //LDR
				begin
					SR1MUX = 1'b1;
					ADDR1MUX = 1'b1;
					ADDR2MUX = 2'b01;
					GateMARMUX = 1'b1;
					LD_MAR = 1'b1;
				end
			LDRPT2 :
				Mem_OE = 1'b0;
			LDRPT3 :
				begin
					Mem_OE = 1'b0;
					LD_MDR = 1'b1;
				end
			LDRPT4 :
				begin
					GateMDR = 1'b1;
					DRMUX = 1'b0;
					LD_REG = 1'b1;
					LD_CC = 1'b1;
				end
				
			S_07 : //STR
				begin
					SR1MUX = 1'b1;
					ADDR1MUX = 1'b1;
					ADDR2MUX = 2'b01;
					GateMARMUX = 1'b1;
					LD_MAR = 1'b1;					
				end
			STRPT2 :
				begin
					SR1MUX = 1'b0;
					ALUK = 2'b11;
					GateALU = 1'b1;
					Mem_OE = 1'b1;
					LD_MDR = 1'b1;
				end
			STRPT3 :
				Mem_WE = 1'b0;
			STRPT4 :
				Mem_WE = 1'b0;
			// You need to finish the rest of states.....

			default : ;
		endcase
	end 

	 // These should always be active
	assign Mem_CE = 1'b0;
	assign Mem_UB = 1'b0;
	assign Mem_LB = 1'b0;
	
endmodule
