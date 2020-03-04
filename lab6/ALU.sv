module ALU(input logic [15:0] A, B, 
			  input logic [1:0] ALUK,
			  output logic [15:0] Out);
	
logic [15:0] ADD, AND, XOR; //Internal logic for operations
	
//ALU Operations
assign ADD = A + B;
assign AND = A & B;
assign XOR = A ^ B;

//ALU Mux
fourmux_16bit ALU_MUX(.A(ADD), .B(AND), .C(XOR), .D(A), .Select(ALUK), .Out(Out));
			  
endmodule 