/*
 * main.c
 *
 *  Created on: Mar 12, 2020
 *      Author: Soham Makani
 */


// Main.c - makes LEDG0 on DE2-115 board blink if NIOS II is set up correctly
/*
int main()
{
	int i = 0;
	volatile unsigned int *LED_PIO = (unsigned int*)0x90; //make a pointer to access the PIO block

	*LED_PIO = 0; //clear all LEDs
	while ( (1+1) != 3) //infinite loop
	{
		for (i = 0; i < 100000; i++); //software delay
		*LED_PIO |= 0x1; //set LSB
		for (i = 0; i < 100000; i++); //software delay
		*LED_PIO &= ~0x1; //clear LSB
	}
	return 1; //never gets here
}

*/
int main()
{
	int i = 0;

	volatile unsigned int *KEY2 =  (unsigned int*)0x70;
	volatile unsigned int *KEY3 =  (unsigned int*)0x60;


	volatile unsigned int *SW_PIO =  (unsigned int*)0x80;//switches
	volatile unsigned int *LED_PIO = (unsigned int*)0x90; //make a pointer to access the PIO block

	*LED_PIO = 0; //clear all LEDs
	unsigned int b = 0x0;
	unsigned int sum;
	sum = *LED_PIO;
	while (1) //infinite loop
	{

		for (i = 0; i < 100000; i++){
			if(!(*KEY2)) {
				*LED_PIO = 0x0;
				b = 0x0;
			}
		};
			if(!(*KEY3)) {
				unsigned int a = *SW_PIO;
				b = b + a;
				if(b > 255) {
					b = b - 256;
				}
				*LED_PIO = b;
				for (i = 0; i < 100000; i++){
					if(i = 500){
						break;
					}
					}
				}
			}
	return 1; //never gets here
}

