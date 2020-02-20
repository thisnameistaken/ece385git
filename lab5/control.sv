<<<<<<< HEAD
module control (input logic Clk, Reset, Run, ClearA_LoadB, x_in,
					 input logic [7:0] Bin,
					 output logic Clr_Ld, Shift, Add, Sub, X, ClearA); //Control unit
					 
	enum logic [4:0] {A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R} curr_state, next_state; //Logic for control unit states/counter
=======
module control (input logic Clk, Reset, Run, ClearA_LoadB, input logic [7:0] B,
					 output logic Clr_Ld, Shift, Add, Sub, X, clearA); //Control unit
					 
	enum logic [3:0] {A, ADD, SUB, Bstate, C, D, E, F, G, H, I, J} curr_state, next_state; //Logic for control unit states/counter
	logic MS = B[7];
	logic [3:0] temp;
>>>>>>> 9eb7ff3ea75900aca39e99f23240c268b667bb17
	
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
        
		  next_state = curr_state;	//required because I haven't enumerated all possibilities below
        unique case (curr_state) 

<<<<<<< HEAD
            A :  	  if (Run) 
							  next_state = B;
						  else
								next_state = A;
					  
            B : begin
						 if(Bin[0]) begin						 
							next_state = C;
=======
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
>>>>>>> 9eb7ff3ea75900aca39e99f23240c268b667bb17
							end
						 else
							next_state = D;
<<<<<<< HEAD
					 end
						 
            C : begin
						next_state = D;
					 end
					 
            D : begin
						 if(Bin[0]) begin						 
							next_state = E;
=======
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
>>>>>>> 9eb7ff3ea75900aca39e99f23240c268b667bb17
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
<<<<<<< HEAD
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
					    else next_state = B;
							  
        endcase
=======
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
>>>>>>> 9eb7ff3ea75900aca39e99f23240c268b667bb17
		  
	 
        case (curr_state) 
	   	   A: //Rest state. Set everything to zero
	         begin
				if (Reset) 
					begin 
					 Clr_Ld = 1'b0;
                Shift  = 1'b0;
					 Add = 1'b0;
					 Sub = 1'b0;
					 X = 1'b0;
					 ClearA = 1'b1;
					end  
				else if (Run) begin
					 Clr_Ld = 1'b0;
                Shift  = 1'b0;
					 Add = 1'b0;
					 Sub = 1'b0;
					 X = 1'b0;
					 ClearA = 1'b0;
					end
				else
                Clr_Ld = ClearA_LoadB;
                Shift  = 1'b0;
					 Add = 1'b0;
					 Sub = 1'b0;
					 X = x_in;
					 ClearA = 1'b0;
		      end
				
<<<<<<< HEAD
				B, D, F, H, J, L, N: begin
					if (Bin[0]) begin
                Clr_Ld = 1'b0;
                Shift  = 1'b0;
					 Add = 1'b1;
					 Sub = 1'b0;
					 X = x_in;
					 ClearA = 1'b0;
					end
					else begin
					 Clr_Ld = 1'b0;
                Shift  = 1'b1;
					 Add = 1'b0;
					 Sub = 1'b0;
					 X = x_in;
					 ClearA = 1'b0;
					 end
				end
=======
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
>>>>>>> 9eb7ff3ea75900aca39e99f23240c268b667bb17
				
				C, E, G, I, K, M, O: begin
                Clr_Ld = 1'b0;
                Shift  = 1'b1;
					 Add = 1'b0;
					 Sub = 1'b0;
					 X = x_in;
					 ClearA = 1'b0;					
				end
				
				P: begin
					if(Bin[0]) begin
                Clr_Ld = 1'b0;
                Shift  = 1'b0;
					 Add = 1'b0;
					 Sub = 1'b1;
					 X = x_in;
					 ClearA = 1'b0;
					 end
					 else begin
                Clr_Ld = 1'b0;
                Shift  = 1'b1;
					 Add = 1'b0;
					 Sub = 1'b0;
					 X = x_in;
					 ClearA = 1'b0;					 
					 end
				end
				
				Q: begin
                Clr_Ld = 1'b0;
                Shift  = 1'b1;
					 Add = 1'b0;
					 Sub = 1'b0;
					 X = x_in;
					 ClearA = 1'b0;	
					end
				
	   	   R: //Last state
		      begin
                Clr_Ld = 1'b0;
                Shift  = 1'b0;
					 Add = 1'b0;
					 Sub = 1'b0;
					 X = x_in;
					 ClearA = 1'b0;	
		      end	
				
<<<<<<< HEAD
        endcase
    end
	 
endmodule 
=======
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
>>>>>>> 9eb7ff3ea75900aca39e99f23240c268b667bb17
