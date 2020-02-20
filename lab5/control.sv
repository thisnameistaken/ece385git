module control (input logic Clk, Reset, Run, ClearA_LoadB, [7:0] B,
					 output logic Clr_Ld, Shift, Add, Sub, X, clearA); //Control unit
					 
	enum logic [3:0] {A, ADD, SUB, B, C, D, E, F, G, H, I, J} curr_state, next_state; //Logic for control unit states/counter
	logic MS = B[7];
	logic [3:0] temp;
	
	always_ff @ (posedge Clk)
	begin
	if (Reset)
		curr_state <= A;
	else
		curr_state <= next_state;
	end
		
	always_comb
    begin
        
		  next_state  = curr_state;	//required because I haven't enumerated all possibilities below
        unique case (curr_state) 

            A :    if (Run) begin
							  X = 0; 
							  next_state = B;
							  clearA = 1;
						  
							  
				ADD:		next_state = temp;
				SUB:		next_state = J;
				
            B :    clearA = 0;
						 if(B[0]) begin
							temp = C;
							next_state = ADD;
							end
						 else begin
							next_state = C;
						 end
						 
            C :    if(B[0]) begin
							temp = D;
							next_state = ADD;
							end
						 else begin
							next_state = D;
						 end
						 
            D :    if(B[0]) begin
							temp = E;
							next_state = ADD;
							end
						 else begin
							next_state = E;
						 end
						 
            E :    if(B[0]) begin
							temp = F;
							next_state = ADD;
							end
						 else begin
							next_state = G;
						 end
						 
				F :    if(B[0]) begin
							temp = G;
							next_state = ADD;
							end
						 else begin
							next_state = G;
						 end
						 
            G :    if(B[0]) begin
							temp = H;
							next_state = ADD;
							end
						 else begin
							next_state = H;
						 end
						 
				H : 	 if(B[0]) begin
							temp = I;
							next_state = ADD;
							end
						 else begin
							next_state = I;
						 end
						 
				I : 	 if(MS) begin
							temp = J;
							next_state = SUB;
							end
						 else begin
							next_state = J;
						 end
						 
            J :    if (~Run) 
                       next_state = A;
							  
        endcase
		  
        case (curr_state) 
	   	   A: //Rest state. Set everything to zero
	         begin
				if (Reset) 
					begin 
					 Clr_Ld = 1'b0;
                Shift  = 1'b0;
					 Add = 1'b0;
					 Sub = 1'b0;
					end  
                Clr_Ld = ClearA_LoadB;
                Shift  = 1'b0;
					 Add = 1'b0;
					 Sub = 1'b0;
		      end
				
				I: //Possible Subtraction state
				begin 
					if(MS)
						Sub = 1'b1;
						Shift = 1'b0;
					else
						Sub = 1'b0;
						Shift = 1'b1;
		      end
				
	   	   J: //Last state. Clear X and A
		      begin
                Shift = 1'b0;
					 Add = 1'b0;
					 Sub = 1'b0;
		      end
				ADD:
				begin
					Add = 1'b0;
					Shift = 1'b1;
				end
				
				
	   	   default:  //Default state. Checks whether to add or shift
		      begin 
					if(B[0])
						Add = 1'b1;
						Shift = 1'b0;
					else
						Add = 1'b0;
						Shift = 1'b1;
		      end
        endcase
    end

endmodule