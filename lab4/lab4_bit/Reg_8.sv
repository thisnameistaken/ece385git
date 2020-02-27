module reg_4 (input  logic Clk, Reset, Shift_In, Load, Shift_En,
              input  logic [7:0]  D, //Change made from 4 to 8
              output logic Shift_Out,
              output logic [7:0]  Data_Out); //Change made from 4 to 8

    always_ff @ (posedge Clk)
    begin
	 	 if (Reset) //notice, this is a sycnrhonous reset, which is recommended on the FPGA
			  Data_Out <= 8'h0; //Change made from 4 to 8
		 else if (Load)
			  Data_Out <= D;
		 else if (Shift_En)
		 begin
			  //concatenate shifted in data to the previous left-most 3 bits
			  //note this works because we are in always_ff procedure block
			  Data_Out <= { Shift_In, Data_Out[7:1] }; //Change made from 4 to 8
	    end
    end
	
    assign Shift_Out = Data_Out[0];

endmodule
