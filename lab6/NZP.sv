module NZPReg(input logic [2:0] nzp, input  logic Clk, Reset, Load, input logic [15:0] Bus, 
              output logic BEnable);

    always_ff @ (posedge Clk)
    begin
	 	if (Reset) //Reset register
			BEnable <= 1b'0; 
		else if (Load) 
        begin
            if(Bus[15] && nzp[2])
                BEnable <= 1'b1;
            
            else if(~Bus[15] && nzp[1])
                BEnable <= 1'b1;

            else if(~Bus[15] && nzp[0])
                BEnable <= 1'b1;
        end
			  
    end


endmodule