module control (input logic Clk, Reset, Run, ClearA_LoadB, input logic [7:0] B,
					 output logic Clr_Ld, Shift, Add, Sub, X, clearA); //Control unit
					 
	enum logic [3:0] {A, ADD, SUB, Bstate, C, D, E, F, G, H, I, J} curr_state, next_state; //Logic for control unit states/counter
	logic MS = B[7];
	logic [3:0] temp;
	
	always_ff @ (posedge Clk)
	begin
	if (Reset) begin
		curr_state <= A;
		end
	else begin
		curr_state <= next_state;
		end
	end
		
	always_comb
    begin
        
		  next_state  = curr_state;	//required because I haven't enumerated all possibilities below
        unique case (curr_state) 

            A :   begin
						if (Run) begin
							  X = 0; 
							  next_state = Bstate;
							  clearA = 1;
						end
						
						  
							  
				ADD:		next_state = temp;
				SUB:		next_state = J;
				
            Bstate : begin  
							clearA = 0;
						 if(B[0]) begin
							temp = C;
							next_state = ADD;
							end
						 else begin
							next_state = C;
						 end
				end
						 
            C :    begin
							if(B[0]) begin
							temp = D;
							next_state = ADD;
							end
						 else begin
							next_state = D;
						 end
					end
						 
            D :    begin
						if(B[0]) begin
							temp = E;
							next_state = ADD;
							end
						 else begin
							next_state = E;
						 end
					end
						 
            E :    begin 
				
					if(B[0]) begin
							temp = F;
							next_state = ADD;
							end
						 else begin
							next_state = G;
						 end
					end
						 
				F :   begin 
						if(B[0]) begin
							temp = G;
							next_state = ADD;
							end
						 else begin
							next_state = G;
						 end
					end
						 
            G :   begin
						if(B[0]) begin
							temp = H;
							next_state = ADD;
							end
						 else begin
							next_state = H;
						 end
					end
						 
				H : 	begin
					if(B[0]) begin
							temp = I;
							next_state = ADD;
							end
						 else begin
							next_state = I;
						 end
					end
						 
				I : 	begin
						if(MS) begin
							temp = J;
							next_state = SUB;
							end
						 else begin
							next_state = J;
						 end
					end
						 
            J :   begin
					if (~Run) begin 
                       next_state = A;
						end
					end
        end 
		  endcase
		  end
	always_comb
    begin		  
		  
	 
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
					if(MS) begin
						Sub = 1'b1;
						Shift = 1'b0;
						end
					else begin
						Sub = 1'b0;
						Shift = 1'b1;
					end
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
					if(B[0]) begin
						Add = 1'b1;
						Shift = 1'b0;
					end
					else begin
						Add = 1'b0;
						Shift = 1'b1;
					end
        end
    endcase
    end
endmodule