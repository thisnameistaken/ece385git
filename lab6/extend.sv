/*module sext
    #(parameter width = 10)
    (input logic [width - 1:0]in, output logic [15:0]out);

   always_comb
    begin
		out = { {16 - size { in[size - 1] }}, in};
    end

endmodule*/

module sextfive (input logic [4:0]in, output logic [15:0]out);
   
   always_comb
    begin
		out = { {11{in[4]}}, in};
    end

endmodule


module sextsix (input logic [5:0]in, output logic [15:0]out);

   always_comb
    begin
		out = { {10{in[5]}}, in};
    end

endmodule

module sextnine (input logic [8:0]in, output logic [15:0]out);

   always_comb
    begin
		out = { {7{in[8]}}, in} ;
    end

endmodule

module sexteleven (input logic [10:0]in, output logic [15:0]out);

   always_comb
    begin
		out = { {5{in[10]}}, in};
    end

endmodule