module control (input logic Clk, Reset, Run, ClearA_LoadB, input logic [7:0] B,
					 output logic Clr_Ld, Shift, Add, Sub, X, clearA); //Control unit
					 
	enum logic [3:0] {Rest, ADD, SUB, Shift0, Shift1, Shift2, Shift3, Shift4, Shift5, Shift6, Shift7} curr_state, next_state; //Logic for control unit states/counter
	logic MS = B[7];
	logic [3:0] temp;
	
	always_ff @ (posedge Clk)
	begin
	if (Reset) begin
		curr_state <= Rest;
		end
	else begin
		curr_state <= next_state;
		end
	end
		
	always_comb
    begin
	 
	 next_state  = curr_state;	//required because I haven't enumerated all possibilities below
        unique case (curr_state) 
		  
		  Rest :   begin
						if (Run) begin
							  X = 0; 
							  next_state = Shift0;
							  clearA = 1;
						end
						begin
	 
        
		  
    end
endmodule