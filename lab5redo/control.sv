module control (input logic Clk, Reset, Run, ClearA_LoadB,
					 input logic [7:0] Bin,
					 output logic Clr_Ld, Shift, Add, Sub, ClearA); //Control unit
					 
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
					  
            B : begin
						 if(Bin[0]) begin						 
							next_state = C;
							end
						 else
							next_state = D;
					 end
						 
            C : begin
						next_state = D;
					 end
					 
            D : begin
						 if(Bin[0]) begin						 
							next_state = E;
							end
						 else
							next_state = F;
					 end
						 
            E : begin
						next_state = F;
					 end
						 
            F : begin
						 if(Bin[0]) begin						 
							next_state = G;
							end
						 else
							next_state = H;
					 end
						 
            G : begin
						next_state = H;
					 end
						 
            H : begin
						 if(Bin[0]) begin					 
							next_state = I;
							end
						 else
							next_state = J;
					 end
						 
            I : begin
						next_state = J;
					 end
					 
            J : begin
						 if(Bin[0]) begin					 
							next_state = K;
							end
						 else
							next_state = L;
					 end
						 
            K : begin
						next_state = L;
					 end					 
						 
            L : begin
						 if(Bin[0]) begin					 
							next_state = M;
							end
						 else
							next_state = N;
					 end
						 
            M : begin
						next_state = N;
					 end		
	
            N : begin
						 if(Bin[0]) begin
							next_state = O;
							end
						 else
							next_state = P;
					 end
						 
            O : begin
						next_state = P;
					 end	
					 
            P : begin
						 if(Bin[0]) begin
							next_state = Q;
							end
						 else
							next_state = R;
					 end
						 
            Q : begin
						next_state = R;
					 end					 
						 
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
					 ClearA = 1'b1;
					end  
				else if (Run) begin
					 Clr_Ld = 1'b0;
                Shift  = 1'b0;
					 Add = 1'b0;
					 Sub = 1'b0;
					 ClearA = 1'b1;
					end
				else
                Clr_Ld = ClearA_LoadB;
                Shift  = 1'b0;
					 Add = 1'b0;
					 Sub = 1'b0;
					 ClearA = ClearA_LoadB;
		      end
				
				B, D, F, H, J, L, N: begin
					if (Bin[0]) begin
                Clr_Ld = 1'b0;
                Shift  = 1'b0;
					 Add = 1'b1;
					 Sub = 1'b0;
					 ClearA = 1'b0;
					end
					else begin
					 Clr_Ld = 1'b0;
                Shift  = 1'b1;
					 Add = 1'b0;
					 Sub = 1'b0;
					 ClearA = 1'b0;
					 end
				end
				
				C, E, G, I, K, M, O: begin
                Clr_Ld = 1'b0;
                Shift  = 1'b1;
					 Add = 1'b0;
					 Sub = 1'b0;
					 ClearA = 1'b0;					
				end
				
				P: begin
					if(Bin[0]) begin
                Clr_Ld = 1'b0;
                Shift  = 1'b0;
					 Add = 1'b0;
					 Sub = 1'b1;
					 ClearA = 1'b0;
					 end
					 else begin
                Clr_Ld = 1'b0;
                Shift  = 1'b1;
					 Add = 1'b0;
					 Sub = 1'b0;
					 ClearA = 1'b0;					 
					 end
				end
				
				Q: begin
                Clr_Ld = 1'b0;
                Shift  = 1'b1;
					 Add = 1'b0;
					 Sub = 1'b0;
					 ClearA = 1'b0;	
					end
				
	   	   R: //Last state
		      begin
                Clr_Ld = 1'b0;
                Shift  = 1'b0;
					 Add = 1'b0;
					 Sub = 1'b0;
					 ClearA = 1'b0;	
		      end	
				
        endcase
    end
	 
endmodule 