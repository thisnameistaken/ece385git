module sex(input [7:0]in, output [8:0]out);

   always_comb
    begin
			out[7:0] = in;
			out[8] = in[7];
    end

endmodule