/************************************************************************
Lab 9 Nios Software

Dong Kai Wang, Fall 2017
Christine Chen, Fall 2013

For use with ECE 385 Experiment 9
University of Illinois ECE Department
************************************************************************/

#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <string.h>
#include "aes.h"

// Pointer to base address of AES module, make sure it matches Qsys
volatile unsigned int * AES_PTR = (unsigned int *) 0x00000100;

// Execution mode: 0 for testing, 1 for benchmarking
int run_mode = 0;

/** charToHex
 *  Convert a single character to the 4-bit value it represents.
 *  
 *  Input: a character c (e.g. 'A')
 *  Output: converted 4-bit value (e.g. 0xA)
 */
char charToHex(char c)
{
	char hex = c;

	if (hex >= '0' && hex <= '9')
		hex -= '0';
	else if (hex >= 'A' && hex <= 'F')
	{
		hex -= 'A';
		hex += 10;
	}
	else if (hex >= 'a' && hex <= 'f')
	{
		hex -= 'a';
		hex += 10;
	}
	return hex;
}

/** charsToHex
 *  Convert two characters to byte value it represents.
 *  Inputs must be 0-9, A-F, or a-f.
 *  
 *  Input: two characters c1 and c2 (e.g. 'A' and '7')
 *  Output: converted byte value (e.g. 0xA7)
 */
char charsToHex(char c1, char c2)
{
	char hex1 = charToHex(c1);
	char hex2 = charToHex(c2);
	return (hex1 << 4) + hex2;
}


/************************************************************************
PART 1 FUNCTIONS
PART 1 FUNCTIONS
PART 1 FUNCTIONS
PART 1 FUNCTIONS
PART 1 FUNCTIONS
BEGIN BEGIN BEGIN BEGIN
************************************************************************/


//uchar is unsigned char

/*Takes the Cipher Key and performs a Key Expansion to generate a
series of Round Keys (4-Word matrix) and store them into Key
Schedule.*/

void KeyExpansion(uchar* key, uchar* keySchedule){
		
		for(int copyloop =0; copyloop < 16; copyloop++){
			keySchedule[copyloop] = key[copyloop];
		}
		
		uchar tmp[4];
		uchar tr;

		for(int i = 16; i < 176; i++){
			for(int j = 0; j< 4; j++){
				tmp[j] = keySchedule[i-4 + j];
			}

			if(!(i%16)){
				//rotate
				
				tr = tmp[0];
				tmp[0] = tmp[1];
				tmp[1] = tmp[2];
				tmp[2] = tmp[3];
				tmp[3] = tr;

				for(int k = 0; k < 4; k++){
					tmp[k] = aes_sbox[tmp[k]];
					tmp[k] ^= Rcon[i/16];
				}
			}

			for(int l = 0; l< 4; l++){
				keySchedule[i] = tmp[l] ^ keySchedule[i-16];
			}
		}

};
 
//the tutorial uses Nk parameter to achieve flexibilty
 
//on AES length (see About AES)
 
//but we don't necessarily need it

/*
void AES(uchar* keySchedule, uchar* in, uchar* out){

};
 
//this is a wrapper function
*/

void MixColumns(uchar* msg){

	uchar tmp[16];

	for(int copyloop =0; copyloop < 16; copyloop++){
		tmp[copyloop] =  msg[copyloop];
	}
	//make a copy and store in tmp;

	for(int i = 0; i < 16; i++){
		switch(i%4){

			case 0:

				msg[i] = gf_mul[ tmp[i] ][ 0 ] ^ gf_mul[ tmp[i+1] ][ 1 ] ^ tmp[i+2] ^ tmp[i+3];

			break;

			case 1:

				msg[i] = tmp[i-1] ^ gf_mul[ tmp[i] ][ 0 ] ^ gf_mul[ tmp[i+1] ][ 1 ] ^ tmp[i+2];

			break;
			
			case 2:

				msg[i] = tmp[i-2] ^ tmp[i-1] ^ gf_mul[ tmp[i] ][ 0 ] ^ gf_mul[ tmp[i+1] ][ 1 ];  

			break;

			case 3:

				msg[i] = gf_mul[ tmp[i-3] ][ 1 ] ^ tmp[i-2] ^ tmp[i-1] ^ gf_mul[ tmp[i] ][ 0 ];

			break;
		}
	}
	

};
 
//takes the pointer to the current 4*4 matrix
 
void AddRoundKey(uchar* msg, uchar* curr_key){
	for(int i = 0; i<16; i++){
		msg[i] ^= curr_key[i];
	}

};
 
//curr_key is corresponding roundkey
 
void SubByte(uchar* msg){
	for(int i =0; i < 16; i++){
		msg[i] = aes_sbox[msg[i]];
	}
};
 
//you can choose to subbyte all 16 bytes at once
 
void ShiftRows(uchar* msg){
	//first row -> unchanged
	//second row -> shifted left one
	//third row  -> shifted left two
	//fourth row -> shifted left three
	//general rule -> for any row n the values are shifted left n-1
	//uses a CIRCULAR shift
	/*
	[0, 4, 8, C
	 1, 5, 9, D 
	 2, 6, A, E
	 3, 7, B, F
	]

	->

	[0, 4, 8, C
	 5, 9, D, 1
	 A, E, 2, 6
	 F, 3, 7, B
	]

	*/


	uchar tmp = msg[1];
	msg[1] = msg[5];
	msg[5] = msg[9];
	msg[9] = msg[13];
	msg[13] = tmp;

	tmp = msg[2];
	uchar tmp2 = msg[6];
	msg[2] = msg[10];
	msg[6] = msg[14];
	msg[10] = tmp;
	msg[14] = tmp2;

	tmp = msg[3];
	tmp2 = msg[7];
	uchar tmp3 = msg[11];
	msg[3] = msg[15];
	msg[7] = tmp;
	msg[11] = tmp2;
	msg[15] = tmp3;



};
 
//please read About AES for reference

//all taken from KTT

void printer(uchar *msg){


};

/*
pseudocode 

KeyExpansion(byte key[4*Nk], word w[Nb*(Nr+1)], Nk)
begin
word temp
i = 0
while (i < Nk)
 w[i] = word(key[4*i], key[4*i+1], key[4*i+2], key[4*i+3])
 i = i+1
end while
i = Nk
while (i < Nb * (Nr+1)]
 temp = w[i-1]
 if (i mod Nk = 0)
 temp = SubWord(RotWord(temp)) xor Rcon[i/Nk]
 end if
 w[i] = w[i-Nk] xor temp
 i = i + 1
end while
end
*/

/** encrypt
 *  Perform AES encryption in software.
 *
 *  Input: msg_ascii - Pointer to 32x 8-bit char array that contains the input message in ASCII format
 *         key_ascii - Pointer to 32x 8-bit char array that contains the input key in ASCII format
 *  Output:  msg_enc - Pointer to 4x 32-bit int array that contains the encrypted message
 *               key - Pointer to 4x 32-bit int array that contains the input key
 */
void encrypt(unsigned char * msg_ascii, unsigned char * key_ascii, unsigned int * msg_enc, unsigned int * key)
{
	// Implement this function

	uchar tmp0[16];
	uchar tmp1[16];

	for(int copyloop = 0; copyloop< 16; copyloop++){
		tmp0[copyloop] = charsToHex(key_ascii[2 * copyloop], key_ascii[2 * copyloop +1]); 
		tmp1[copyloop] = charsToHex(msg_ascii[2 * copyloop], msg_ascii[2 * copyloop +1]);
	}

	uchar keyS[176];

	KeyExpansion(tmp0, keyS);

	AddRoundKey(tmp1, keyS);

	for(int i = 0; i< 9; i++){
		SubByte(tmp1);
		ShiftRows(tmp1);
		MixColumns(tmp1);
		AddRoundKey(tmp1,keyS+16*(i+1));

	}

	SubByte(tmp1);
	ShiftRows(tmp1);
	AddRoundKey(tmp1,keyS+160);

	for(int j = 0; j< 4; j++){
		msg_enc[j] = tmp1[4 * j] << 24 | tmp1[4 * j + 1] << 16 | tmp1[4 * j + 2] << 8 | tmp1[4 * j +3];
		key[j] = tmp0[4 * j] << 24 | tmp0[4 * j + 1] << 16 | tmp0[4 * j + 2] << 8 | tmp0[4 * j +3];    
	}

};

/*
uchar* charpoint(char* chhh){
	uchar* ret = chhh;

	return ret;
	//return a uchar pointer from  char
}
*/
//not necessary

/************************************************************************
END END END END
PART 1 FUNCTIONS
PART 1 FUNCTIONS
PART 1 FUNCTIONS
PART 1 FUNCTIONS
PART 1 FUNCTIONS
************************************************************************/





/** decrypt
 *  Perform AES decryption in hardware.
 *
 *  Input:  msg_enc - Pointer to 4x 32-bit int array that contains the encrypted message
 *              key - Pointer to 4x 32-bit int array that contains the input key
 *  Output: msg_dec - Pointer to 4x 32-bit int array that contains the decrypted message
 */
void decrypt(unsigned int * msg_enc, unsigned int * msg_dec, unsigned int * key)
{
	// Implement this function
};







/** main
 *  Allows the user to enter the message, key, and select execution mode
 *
 */
int main()
{
	// Input Message and Key as 32x 8-bit ASCII Characters ([33] is for NULL terminator)
	unsigned char msg_ascii[33];
	unsigned char key_ascii[33];
	// Key, Encrypted Message, and Decrypted Message in 4x 32-bit Format to facilitate Read/Write to Hardware
	unsigned int key[4];
	unsigned int msg_enc[4];
	unsigned int msg_dec[4];

	printf("Select execution mode: 0 for testing, 1 for benchmarking: ");
	scanf("%d", &run_mode);

	if (run_mode == 0) {
		// Continuously Perform Encryption and Decryption
		while (1) {
			int i = 0;
			printf("\nEnter Message:\n");
			scanf("%s", msg_ascii);
			printf("\n");
			printf("\nEnter Key:\n");
			scanf("%s", key_ascii);
			printf("\n");
			encrypt(msg_ascii, key_ascii, msg_enc, key);
			printf("\nEncrpted message is: \n");
			for(i = 0; i < 4; i++){
				printf("%08x", msg_enc[i]);
			}
			printf("\n");
			decrypt(msg_enc, msg_dec, key);
			printf("\nDecrypted message is: \n");
			for(i = 0; i < 4; i++){
				printf("%08x", msg_dec[i]);
			}
			printf("\n");
		}
	}
	else {
		// Run the Benchmark
		int i = 0;
		int size_KB = 2;
		// Choose a random Plaintext and Key
		for (i = 0; i < 32; i++) {
			msg_ascii[i] = 'a';
			key_ascii[i] = 'b';
		}
		// Run Encryption
		clock_t begin = clock();
		for (i = 0; i < size_KB * 64; i++)
			encrypt(msg_ascii, key_ascii, msg_enc, key);
		clock_t end = clock();
		double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
		double speed = size_KB / time_spent;
		printf("Software Encryption Speed: %f KB/s \n", speed);
		// Run Decryption
		begin = clock();
		for (i = 0; i < size_KB * 64; i++)
			decrypt(msg_enc, msg_dec, key);
		end = clock();
		time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
		speed = size_KB / time_spent;
		printf("Hardware Encryption Speed: %f KB/s \n", speed);
	}
	return 0;
};
