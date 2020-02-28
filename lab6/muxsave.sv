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

module fourmux_16bit(input logic [15:0] A, B, C, D, input logic [1:0] Select, output logic [15:0] Out);
		
		always_comb begin
			if(Select[1] == 1'b0 && Select[0] == 1'b0) begin
				Out = A;
			end
			
			else if(Select[1] == 1'b0 && Select[0] == 1'b1) begin
				Out = B;
			end
			
			else if(Select[1] == 1'b1 && Select[0] == 1'b0) begin
				Out = C;
			end
			
			else begin
				Out = D;
			end
		end

endmodule

module threemux_16bit(input logic [15:0] A, B, C, input logic [1:0] Select, output logic [15:0] Out);
		
		always_comb begin
			if(Select[1] == 1'b0 && Select[0] == 1'b0) begin
				Out = A;
			end
			
			else if(Select[1] == 1'b0 && Select[0] == 1'b1) begin
				Out = B;
			end
			
			else begin
				Out = C;
			end
		end

endmodule
