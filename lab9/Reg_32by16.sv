//adapted from kttech blog for lab9 
/*module reg_32 (
                input  logic Clk,
                input  logic Reset,
                input  logic AVL_READ,
	            input  logic AVL_WRITE,
                input  logic AVL_CS,
                input  logic [3:0] AVL_BYTE_EN,
                input  logic [3:0] AVL_ADDR,
                input  logic [31:0] AVL_WRITEDATA,
                input  logic [31:0] register_file[16],
                input  logic AES_DONE,
                input  logic [127:0] AES_MSG_DEC, 

                output logic [31:0] AVL_READDATA,
                output logic AES_START,
                output logic [31:0] EXPORT_DATA,
                output logic [127:0] AES_KEY,
                output logic [127:0] AES_MSG_ENC


    ); 
    always_ff @ (posedge Clk) begin //:REGISTER_FILE
 
        if(Reset) begin

            for(int i = 0; i< 4; i++) begin
                register_file[i] <= 0;
            end// end for

        end //end if reset



        else if(AVL_WRITE && AVL_CS) begin//begin: SW_WRITE_TO_REG

            if(AVL_BYTE_EN[0])
 
                register_file[AVL_ADDR][ 7:0] <= AVL_WRITEDATA[ 7:0];
 
            if(AVL_BYTE_EN[1])
 
                register_file[AVL_ADDR][15:8] <= AVL_WRITEDATA[15:8];

            if(AVL_BYTE_EN[2])
 
                register_file[AVL_ADDR][23:16] <= AVL_WRITEDATA[23:16];

            if(AVL_BYTE_EN[3])
 
                register_file[AVL_ADDR][31:24] <= AVL_WRITEDATA[31:24];
        end    
 
        else begin //HW_WRITE_TO_REG
 
        //you declare hardware_write
        //8-11
 
            register_file[8]  <= AES_MSG_DEC[31:0];
            register_file[9]  <= AES_MSG_DEC[63:32];
            register_file[10] <= AES_MSG_DEC[95:64];
            register_file[11] <= AES_MSG_DEC[127:96];

            register_file[15][0] <= AES_DONE; //done is input to regfile
            AES_START <= register_file[14][0]; //start is output from regfile
        end
    end //always ff finish
 
    assign AVL_READDATA = (AVL_CS && AVL_READ) ? register_file[AVL_ADDR] :32'b0;
    assign  

endmodule
*/


//cant use registerfile variable like this lmao rip making a nice looking toplevel

/*reg_32  aesregisterfile(
					.Clk
					.Reset
                	.AVL_READ(AVL_READ),
	            	.AVL_WRITE(AVL_WRITE),
                	.AVL_CS(AVL_CS),
                	.AVL_BYTE_EN(AVL_BYTE_EN),
                	.AVL_ADDR(AVL_ADDR),
                	.AVL_WRITEDATA(AVL_WRITEDATA),
                	.register_file(register_file),
                	.AES_DONE(AES_DONE),
                	.AES_MSG_DEC(AES_MSG_DEC), 

                	.AVL_READDATA(AVL_READDATA),
                	.AES_START(AES_START),
                	.EXPORT_DATA(EXPORT_DATA),
                	.AES_KEY(AES_KEY),
                	.AES_MSG_ENC(AES_MSG_ENC)


    ); */