//16-bit parallel load register
module reg_16 (input  logic Clk, Reset, Load,
              input  logic [15:0]  D, 
              output logic [15:0]  Data_Out); 

    always_ff @ (posedge Clk)
    begin
	 	 if (Reset) //Reset register
			  Data_Out <= 16'h0; 
		 else if (Load) //Load register
			  Data_Out <= D;
    end

endmodule
