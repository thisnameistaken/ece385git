module NZPReg(input logic [2:0] nzp, input  logic Clk, Reset, LD_CC, input logic [15:0] data_bus, 
              output logic BEnable);

    always_ff @ (posedge Clk)
    begin
	 	if (Reset) //Reset register
			BEnable <= 1'b0; 
		else if (LD_CC) 
        begin
            if(data_bus[15] && nzp[2])
                BEnable <= 1'b1;
            
            else if(~data_bus[15] && nzp[0] && (data_bus != 15'h0000))
                BEnable <= 1'b1;

            else if((data_bus == 15'h0000) && nzp[1])
                BEnable <= 1'b1;
				else
					 BEnable <= 1'b0;
        end
			  
    end

endmodule
