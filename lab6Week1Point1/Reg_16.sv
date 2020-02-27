module reg_16 (input  logic Clk, Reset, Load,
              input  logic [15:0]  D, //Change made from 4 to 8
              output logic [15:0]  Data_Out); //Change made from 4 to 8

    always_ff @ (posedge Clk)
    begin
	 	 if (Reset) //notice, this is a sycnrhonous reset, which is recommended on the FPGA
			  Data_Out <= 16'h0; //Change made from 4 to 8
		 else if (Load)
			  Data_Out <= D;
    end

endmodule
