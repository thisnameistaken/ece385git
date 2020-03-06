module NZPReg(input logic [2:0] nzp, 
				  input  logic Clk, Reset, LD_BEN,
				  input logic [15:0] check, 
              output logic BEnable);

    always_ff @ (posedge Clk)
    begin
	 	if (Reset) //Reset register
			BEnable <= 1'b0; 
		else if (LD_BEN) 
        begin
            if(check[15] && nzp[2])
                BEnable <= 1'b1;
            
            else if(~check[15] && nzp[0] && (check != 16'h0000))
                BEnable <= 1'b1;

            else if((check == 16'h0000) && nzp[1])
                BEnable <= 1'b1;
				else
					 BEnable <= 1'b0;
        end
			  
    end

endmodule
