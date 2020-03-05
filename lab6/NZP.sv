module NZPReg(input logic [2:0] nzp, input  logic Clk, Reset, LD_CC, LD_BEN,
				  input logic [15:0] data_bus, 
              output logic BEnable);

    logic [15:0] checker;

    always_ff @ (posedge Clk)
    begin
	 	if (Reset) //Reset register
			BEnable <= 1'b0; 
        else if (LD_CC)
            checker = data_bus;
		else if (LD_BEN) 
        begin
            if(checker[15] && nzp[2])
                BEnable <= 1'b1;
            
            else if(~checker[15] && nzp[0] && (checker != 15'h0000))
                BEnable <= 1'b1;

            else if((checker == 15'h0000) && nzp[1])
                BEnable <= 1'b1;
				else
					 BEnable <= 1'b0;
        end
			  
    end

endmodule
