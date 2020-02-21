module control (input logic Clk, Reset, Run, ClearA_LoadB,
					 input logic [7:0] Bin,
					 output logic Clr_Ld, Shift, Add, Sub); //Control unit
	//x should not appear at all in this file 				 
	enum logic [4:0] {Rest, Add0, Add1, Add2, Add3, Add4, Add5, Add6, Sub1, 
							Shift0, Shift1, Shift2, Shift3, Shift4, Shift5, Shift6, Shift7, 
							End} curr_state, next_state; 
							//Logic for control unit states/counter
	
	always_ff @ (posedge Clk)
	begin
	if (Reset)
		curr_state <= Rest;
	else
		curr_state <= next_state;
	end
		
	always_comb
    begin
        
		  next_state = curr_state;	//required because I haven't enumerated all possibilities below
        unique case (curr_state) 

            Rest :  	  if (Run) 
							  next_state = Add0;
				Add0 :  next_state = Shift0;
				Shift0 : next_state = Add1;
				
				Add1 :  next_state = Shift1;
				Shift1 : next_state = Add2;
				
				Add2 :  next_state = Shift2;
				Shift2 : next_state = Add3;
				
				Add3 :  next_state = Shift3;
				Shift3 : next_state = Add4;
				
				Add4 :  next_state = Shift4;
				Shift4 : next_state = Add5;
				
				Add5 :  next_state = Shift5;
				Shift5 : next_state = Add6;
			   
				Add6 :  next_state = Shift6;
				Shift6 : next_state = Sub1;
				
				Sub1 :  next_state = Shift7;
				Shift7 : next_state = End;
					  
            		 
						 
            End:    if (~Run) 
                       next_state = Rest;
							  
        endcase
end
always_comb
begin		  
        case (curr_state) 
	   	   Rest: //Rest state. Set everything to zero
	         begin
				    if (Reset) begin 
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
				
				Add0, Add1, Add2, Add3, Add4, Add5, Add6: begin
					 Clr_Ld = 1'b0;
                Shift  = 1'b0;
					if (Bin[0]) begin
					 Add = 1'b1;
					 Sub = 1'b0;
					end
					else begin
					 Add = 1'b0;
					 Sub = 1'b0;
					 end
				end
				
				Shift0, Shift1, Shift2, Shift3, Shift4, Shift5, Shift6, Shift7: begin
                Clr_Ld = 1'b0;
                Shift  = 1'b1;
					 Add = 1'b0;
					 Sub = 1'b0; 				
				end
				
				Sub1: begin
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
				
				
	   	   End: //Last state
		      begin
                Clr_Ld = 1'b0;
                Shift  = 1'b0;
					 Add = 1'b0;
					 Sub = 1'b0;
					 
		      end	
				
        endcase
    end
	 
endmodule 