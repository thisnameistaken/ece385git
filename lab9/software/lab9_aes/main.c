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
LAB 1 FUNCTIONS
LAB 1 FUNCTIONS
LAB 1 FUNCTIONS
LAB 1 FUNCTIONS
LAB 1 FUNCTIONS
BEGIN BEGIN BEGIN BEGIN
************************************************************************/


//uchar is unsigned char
 
void KeyExpansion(uchar* key, uchar* keySchedule){

};
 
//the tutorial uses Nk parameter to achieve flexibilty
 
//on AES length (see About AES)
 
//but we don't necessarily need it


void AES(uchar* keySchedule, uchar* in, uchar* out){

};
 
//this is a wrapper function
 
void MixColumns(uchar* msg){

};
 
//takes the pointer to the current 4*4 matrix
 
void AddRoundKey(uchar* msg, uchar* curr_key){
	for(int i = 0; i<16; i++){
		state[i] ^= curr_key[i];
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

//ty KTT ur amazing



/************************************************************************
END END END END
LAB 1 FUNCTIONS
LAB 1 FUNCTIONS
LAB 1 FUNCTIONS
LAB 1 FUNCTIONS
LAB 1 FUNCTIONS
************************************************************************/



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
};

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