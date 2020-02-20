module register_unit (input  logic Clk, Reset, X, Add, Clr_Ld, 
                            Shift, ClearA, aout,
                      input  logic [7:0]  Ain,
							 input  logic [7:0]  Bin, 
                      output logic A_out, B_out, 
                      output logic [7:0]  A,
                      output logic [7:0]  B);

    reg_8  reg_A (.*, .Reset(ClearA || Reset), .Shift_In(X), .Load(Add), .D(Ain[7:0]), .Shift_Out(A_out), .Data_Out(A));
						
						
    reg_8  reg_B (.*, .Shift_In(aout), .Load(Clr_Ld), .D(Bin[7:0]), .Shift_Out(B_out), .Data_Out(B));

endmodule
