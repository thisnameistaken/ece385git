/************************************************************************
Avalon-MM Interface for AES Decryption IP Core

Dong Kai Wang, Fall 2017

For use with ECE 385 Experiment 9
University of Illinois ECE Department

Register Map:

 0-3 : 4x 32bit AES Key
 4-7 : 4x 32bit AES Encrypted Message
 8-11: 4x 32bit AES Decrypted Message
   12: Not Used
	13: Not Used
   14: 32bit Start Register
   15: 32bit Done Register

************************************************************************/

module avalon_aes_interface (
	// Avalon Clock Input
	input logic CLK,
	
	// Avalon Reset Input
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,					// Avalon-MM Read
	input  logic AVL_WRITE,					// Avalon-MM Write
	input  logic AVL_CS,						// Avalon-MM Chip Select
	input  logic [3:0] AVL_BYTE_EN,		// Avalon-MM Byte Enable
	input  logic [3:0] AVL_ADDR,			// Avalon-MM Address
	input  logic [31:0] AVL_WRITEDATA,	// Avalon-MM Write Data
	output logic [31:0] AVL_READDATA,	// Avalon-MM Read Data
	
	// Exported Conduit
	output logic [31:0] EXPORT_DATA		// Exported Conduit Signal to LEDs
);

	//internal logic

	logic [31:0] register_file[16]; //register array
	
	//single inputs from module AES
	logic AES_START; 
	logic AES_DONE;
	
	//128 long inputs from module AES
	logic [127:0] AES_KEY; 
	logic [127:0] AES_MSG_ENC;
	logic [127:0] AES_MSG_DEC;


	always_ff @ (posedge CLK) begin //:REGISTER_FILE
 
        if(RESET) begin

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
 
        else begin //HW_WRITE_TO_REG you declare hardware_write
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

    assign EXPORT_DATA = {register_file[0][15:0] , register_file[3][31:16]};

	/* assign AES_KEY = {register_file[0] , register_file[1] register_file[2] , register_file[3] };

	assign AES_MSG_ENC = {register_file[4] , register_file[5] register_file[6] , register_file[7] }; */




endmodule
