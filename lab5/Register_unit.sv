module register_unit (input  logic Clk, Reset, x1, x2, Add, Clr_Ld, 
                            Shift, ClearA, aout,
                      input  logic [7:0]  Ain,
							 input  logic [7:0]  Bin, 
                      output logic A_out, B_out, X_out,
                      output logic [7:0]  A,
                      output logic [7:0]  B);

    reg_8  reg_A (.*, .Reset(ClearA || Reset), .Shift_In(x2), .Load(Add), .D(Ain[7:0]), .Shift_Out(A_out), .Data_Out(A));
						
						
    reg_8  reg_B (.*, .Shift_In(aout), .Load(Clr_Ld), .D(Bin[7:0]), .Shift_Out(B_out), .Data_Out(B));
	 
	 reg_1 reg_X(.*, .Load(Add), .D(x1), .Data_Out(X_out));

endmodule