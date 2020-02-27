module twomux(input logic A, B, Select, output logic Out);
		
		always_comb begin
			if(Select == 1'b0) begin
				out = A;
			end
			
			else begin
				out = B;
			end
		
		
		
		
		end


endmodule