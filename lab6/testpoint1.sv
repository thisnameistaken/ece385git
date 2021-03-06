module testpoint1();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;







logic [15:0] S;
logic Clk = 0;
logic Reset, Run, Continue;
logic [11:0] LED;
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
logic CE, UB, LB, OE, WE;
logic [19:0] ADDR;
wire [15:0] Data;


integer ErrorCnt = 0;


lab6_toplevel bruh(.*);


always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end		 



initial begin: CLOCK_INITIALIZATION
    Clk = 0;
end 





initial begin: TEST_VECTORS
S = 16'h0;
Run = 1;
Reset = 0;	
Continue = 1;	// Toggle Reset

#2 Reset = 1;

#2 Run = 0;


#2 Run = 1;

#1 S = 16'hffff;


end

endmodule