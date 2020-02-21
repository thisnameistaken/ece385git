module control (input logic Clk, Reset, Run, ClearA_LoadB,
					 input logic [7:0] Bin,
					 output logic Clr_Ld, Shift, Add, Sub); //Control unit
	//x should not appear at all in this file 				 
	enum logic [4:0] {A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R} curr_state, next_state; //Logic for control unit states/counter
	
	always_ff @ (posedge Clk)
	begin
	if (Reset)
		curr_state <= A;
	else
		curr_state <= next_state;
	end
		
	always_comb
    begin
        
		  next_state = curr_state;	//required because I haven't enumerated all possibilities below
        unique case (curr_state) 

            A :  	  if (Run) 
							  next_state = B;
				B :  next_state = C;
			   C :  next_state = D;
				D :  next_state = E;
				E :  next_state = F;
				F :  next_state = G;
				G :  next_state = H;
				H :  next_state = I;
				I :  next_state = J;
				J :  next_state = K;
				K :  next_state = L;
				L :  next_state = M;
				M :  next_state = N;
				N :  next_state = O;
				O :  next_state = P;
				Q :  next_state = R;
					  
            		 
						 
            R:    if (~Run) 
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
				else if (Run) begin
					 Clr_Ld = 1'b0;
                Shift  = 1'b0;
					 Add = 1'b0;
					 Sub = 1'b0;
					end
				else
                Clr_Ld = ClearA_LoadB;
                Shift  = 1'b0;
					 Add = 1'b0;
					 Sub = 1'b0;
		      end
				
				B, D, F, H, J, L, N: begin
					if (Bin[0]) begin
                Clr_Ld = 1'b0;
                Shift  = 1'b0;
					 Add = 1'b1;
					 Sub = 1'b0;
					end
					else begin
					 Clr_Ld = 1'b0;
                Shift  = 1'b0;
					 Add = 1'b0;
					 Sub = 1'b0;
					 
					 end
				end
				
				C, E, G, I, K, M, O: begin
                Clr_Ld = 1'b0;
                Shift  = 1'b1;
					 Add = 1'b0;
					 Sub = 1'b0;
					 				
				end
				
				P: begin
					if(Bin[0]) begin
                Clr_Ld = 1'b0;
                Shift  = 1'b0;
					 Add = 1'b0;
					 Sub = 1'b1;
					 
					 end
					 else begin
                Clr_Ld = 1'b0;
                Shift  = 1'b0;
					 Add = 1'b0;
					 Sub = 1'b0;
										 
					 end
				end
				
				Q: begin
                Clr_Ld = 1'b0;
                Shift  = 1'b1;
					 Add = 1'b0;
					 Sub = 1'b0;
					 
					end
				
	   	   R: //Last state
		      begin
                Clr_Ld = 1'b0;
                Shift  = 1'b0;
					 Add = 1'b0;
					 Sub = 1'b0;
					 
		      end	
				
        endcase
    end
	 
endmodule 