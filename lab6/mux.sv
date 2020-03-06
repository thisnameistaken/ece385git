module twomux_16bit(input logic [15:0] A, B, Select, output logic [15:0] Out);
		
	always_comb 
		begin
			case(Select)
				1'b0 : Out = A;
				1'b1 : Out = B; 
				default : Out = 16'hx;
			endcase
		end
endmodule

module twomux_3bit(input logic [2:0] A, B, Select, output logic [2:0] Out);
		
	always_comb 
		begin
			case(Select)
				1'b0 : Out = A;
				1'b1 : Out = B; 
				default : Out = 3'hx;
			endcase
		end
endmodule

/*
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

endmodule */ //Aren't using these yet, code needs to be modified

//4-to-1 16-bit MUX
module fourmux_16bit(input logic [15:0] A, B, C, D, input logic [1:0] Select, output logic [15:0] Out);

	always_comb
		begin
			case(Select)
			2'b00 : Out = A;
			2'b01 : Out = B;
			2'b10 : Out = C;
			2'b11 : Out = D;
			default : Out = 16'hz;
		endcase
	end
endmodule  

//3-to-1 16-bit MUX
module threemux_16bit(input logic [15:0] A, B, C, input logic [1:0] Select, output logic [15:0] Out);

	always_comb
		begin
			case(Select)
				2'b00 : Out = A;
				2'b01 : Out = B;
				2'b10 : Out = C;
				default : Out = 16'hx;
			endcase
		end
endmodule
			