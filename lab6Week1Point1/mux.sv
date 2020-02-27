module twomux(input logic A, B, Select, output logic Out);
		
		always_comb begin
			if(Select == 1'b0) begin
				Out = A;
			end
			
			else begin
				Out = B;
			end
		
		end

endmodule


module fourmux(input logic A, B, C, D, input logic [1:0] Select, output logic Out);
		
		always_comb begin
			if(Select == 2'b00) begin
				Out = A;
			end
			
			else if(Select == 2'b01) begin
				Out = B;
			end
			
			else if(Select == 2'b10) begin
				Out = C;
			end
			
			else begin
				Out = D;
			end
		end

endmodule



module threemux(input logic A, B, C, input logic [1:0] Select, output logic Out);
		
		always_comb begin
			if(Select == 2'b00) begin
				Out = A;
			end
			
			else if(Select == 2'b01) begin
				Out = B;
			end
			
			else begin
				Out = C;
			end
		end

endmodule

