/*module sext
    
    (input logic [width - 1:0]in, output logic [15:0]out);

   always_comb
    begin
		out = { {16 - size { in[size - 1] }}, in};
    end

endmodule*/

module sextfour (input logic [4:0]in, output logic [15:0]out);
   
   always_comb
    begin
		out = { {11{in[4]}}, in};
    end

endmodule


module sextfive (input logic [5:0]in, output logic [15:0]out);

   always_comb
    begin
		out = { {10{in[5]}}, in};
    end

endmodule

module sexteight (input logic [8:0]in, output logic [15:0]out);

   always_comb
    begin
		out = { {7{in[8]}}, in} ;
    end

endmodule

module sextten (input logic [10:0]in, output logic [15:0]out);

   always_comb
    begin
		out = { {5{in[10]}}, in};
    end

endmodule