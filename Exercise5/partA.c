/*
*******************************************************************************
* @INSTITUTION
*  University of Sao Paulo | Sao Carlos School of Engineering | SEL
*------------------------------------------------------------------------------
* @DISCIPLINE
*  Name: SEL0433 | Applications of Microprocessors I
*  Professor: Evandro Luis Linhari Rodrigues
*  Semester: 2017\01
*------------------------------------------------------------------------------
* @DEVELOPMENT
*  MCU: Intel 8052
*  IDE: MCU 8051 v1.5.7
*  Compiler: SDCC 3.6.0
*------------------------------------------------------------------------------
* @WARRANTY
*  Copyright (c) 2017 Andre Marcos Perez
*  The software is provided by "as is", without warranty of any kind, express or
*  implied, including but not limited to the warranties of merchantability,
*  fitness for a particular purpose and noninfringement. In no event shall the
*  authors or copyright holders be liable for any claim, damages or other
*  liability, whether in an action of contract, tort or otherwise, arising from,
*  out of or in connection with the software or the use or other dealings in the
*  software.
*------------------------------------------------------------------------------
* @EXERCISE
*  Ex. : # 5
*  Part: # --
*------------------------------------------------------------------------------
* @AUTHOR
*  Name:  Andre Marcos Perez
*  Email: andre.marcos.perez@usp.br
*  #USP:  8006891
******************************************************************************/

/*
******************************************************************************
* @LIBRARY
*  Dependency library
*---------------------------------------------------------------------------*/
#include <at89x52.h>

/*
******************************************************************************
* @DEFINITIONS
*  Code's definitions
*---------------------------------------------------------------------------*/
#define	MOTOR_DIRECTION P1_1
#define	MOTOR_CLOCK 	P1_0
#define BUFFER_SIZE 	15
#define TRUE  1
#define FALSE 0

/*
******************************************************************************
* @VARIABLES
*  Code's global variables
*---------------------------------------------------------------------------*/
unsigned char buffer[BUFFER_SIZE];
unsigned char bufferPosition = 0;
unsigned char savedBuffer[] = {10,'A',20,'B',30,'A',40,'B',50,'A'};

/*
********************************************************************************
* @FUNCTION
*  checkInput
*------------------------------------------------------------------------------
* @Description
*  Parses the received keyboard stroke into one number or character and takes an
*  action depending on the what was received. Possible actions are:
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*  Character:   0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'A' or 'B'
*  Description: Enqueues the character received into the buffer.
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*  Character:   C
*  Description: Corrects the last receivec character in the buffer.
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*  Character:   D
*  Description: Performs a pre saved set of commands in the stepper motor.
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*  Character:   E
*  Description: Clears the BUFFER.
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*  Character:   F
*  Description: Perfoms the command sequence stored on the buffer.
*------------------------------------------------------------------------------
* @Param
*  Input: Is the char received
*------------------------------------------------------------------------------
* @Returns
*  Void
*----------------------------------------------------------------------------*/
void checkInput(unsigned char);

/*
********************************************************************************
* @FUNCTION
*  flushBuffer
*------------------------------------------------------------------------------
* @Description
*  Clears buffer.
*------------------------------------------------------------------------------
* @Param
*  Void
*------------------------------------------------------------------------------
* @Returns
*  Void
*----------------------------------------------------------------------------*/
void flushBuffer(void);

/*
********************************************************************************
* @FUNCTION
*  startMotor
*------------------------------------------------------------------------------
* @Description
*  Perfoms a command the stepper motor.
*------------------------------------------------------------------------------
* @Param
*  direction: Is the stepper motor rotation direction.
*  steps:     Is the quantity of steps the stepper motor has to perform.
*------------------------------------------------------------------------------
* @Returns
*  Void
*----------------------------------------------------------------------------*/
void startMotor(unsigned char, unsigned char);

/*
******************************************************************************
* @FUNCTION
*  main
*------------------------------------------------------------------------------
* @Description
*  Software entry point and endless main function.
*-----------------------------------------------------------------------------
* @Param
*  void
*-----------------------------------------------------------------------------
* @Returns
*  void
*---------------------------------------------------------------------------*/
void main(void){

	MOTOR_CLOCK = FALSE;
	while(TRUE){

		P2 = 0xFF;
		P2_4 = 0;
		if(P2_0 == FALSE){

			checkInput(0);
		}
		else if(P2_1 == FALSE){

			checkInput(4);
		}
		else if(P2_2 == FALSE){

			checkInput(8);
		}
		else if(P2_3 == FALSE){

			checkInput('C');
		}
		P2_4 = 1;

		P2_5 = 0;
		if(P2_0 == FALSE){

			checkInput(1);
		}
		else if(P2_1 == FALSE){

			checkInput(5);
		}
		else if(P2_2 == FALSE){

			checkInput(9);
		}
		else if(P2_3 == FALSE){

			checkInput('D');
		}
		P2_5 = 1;

		P2_6 = 0;
		if(P2_0 == FALSE){

			checkInput(2);
		}
		else if(P2_1 == FALSE){

			checkInput(6);
		}
		else if(P2_2 == FALSE){

			checkInput('A');
		}
		else if(P2_3 == FALSE){

			checkInput('E');
		}
		P2_6 = 1;

		P2_7 = 0;
		if(P2_0 == FALSE){

			checkInput(3);
		}
		else if(P2_1 == FALSE){

			checkInput(7);
		}
		else if(P2_2 == FALSE){

			checkInput('B');
		}
		else if(P2_3 == FALSE){

			checkInput('F');
		}
		P2_7 = 1;
	};
}

/* partA.c#checkInput */
void checkInput(unsigned char input){

	switch(input){

		case 0:
		case 1:
		case 2:
		case 3:
		case 4:
		case 5:
		case 6:
		case 7:
		case 8:
		case 9:
		case 'A':
		case 'B':{

			if(bufferPosition < BUFFER_SIZE){

				buffer[bufferPosition] = input;
				bufferPosition++;
			}
			break;
		}

		case 'C':{

			if(bufferPosition > 0){

				bufferPosition--;
				buffer[bufferPosition] = 0;
			}
			break;
		}

		case 'D':{

			unsigned char index;
			unsigned char savedBufferPosition = 0;

			for(index=0 ; index<(BUFFER_SIZE/3) ; index++){

				startMotor(savedBuffer[savedBufferPosition + 1],
					   savedBuffer[savedBufferPosition + 0]);

				savedBufferPosition += 2;
			}
			break;
		}

		case 'E':{

			flushBuffer();
			break;
		}

		case 'F':{

			unsigned char index;

			for(index=0 ; index<(BUFFER_SIZE/3) ; index++){

				if(*(buffer + bufferPosition + 0) == '0' &&
				   *(buffer + bufferPosition + 1) == '0'){

				   	continue;
				}
				if(*(buffer + bufferPosition + 0) == 'A' ||
				   *(buffer + bufferPosition + 0) == 'B'){

					continue;
				}
				if(*(buffer + bufferPosition + 1) == 'A' ||
				   *(buffer + bufferPosition + 1) == 'B'){

					continue;
				}
				if(*(buffer + bufferPosition + 2) != 'A' ||
				   *(buffer + bufferPosition + 2) != 'B'){

					continue;
				}

				startMotor(*(buffer + bufferPosition + 2),
			       	       10*(*(buffer + bufferPosition + 0)) +
			          	  (*(buffer + bufferPosition + 1)));
				bufferPosition += 3;
			}

			flushBuffer();
			break;
		}
	}
}

/* partA.c#flushBuffer */
void flushBuffer(void){

	unsigned char index;

	bufferPosition = 0;
	for(index=0 ; index<BUFFER_SIZE ; index++){

		*(buffer + index) = 0;
	}
}

/* partA.c#startMotor */
void startMotor(unsigned char direction, unsigned char steps){

	unsigned char index;

	MOTOR_DIRECTION = direction == 'A' ? 0 : 1;
	for(index=0 ; index<steps ; index++){

		MOTOR_CLOCK = 1;
		/* delay */
		MOTOR_CLOCK = 0;
	}
}
