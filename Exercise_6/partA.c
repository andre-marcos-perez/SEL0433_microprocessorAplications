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
*  Ex. : # 6
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
* @CONSTANT
*  Code's constants
*---------------------------------------------------------------------------*/
#define TRUE	1
#define FALSE	0

/*
******************************************************************************
* @FUNCTION
*  delay_ms
*------------------------------------------------------------------------------
* @Description
*  Generates a delay between 1 and 65 micro seconds.
*-----------------------------------------------------------------------------
* @Preconditions
*  Timer 0 must be free to be used.
*-----------------------------------------------------------------------------
* @Param
*  delay: The delay in micro seconds
*-----------------------------------------------------------------------------
* @Returns
*  void
*---------------------------------------------------------------------------*/
void delay_ms(unsigned char);

/*
******************************************************************************
* @FUNCTION
*  positiveRamp
*------------------------------------------------------------------------------
* @Description
*  Generates a positive rising ramp wave on the port 2, which is connected to a
*  DAC configured on the autorun mode. The wave has lenght of 0.5 ms and its
*  amplitude is the half of the DAC reference voltage. This implementation does
*  not take into account the DAC conversion delay.
*-----------------------------------------------------------------------------
* @Param
*  void
*-----------------------------------------------------------------------------
* @Returns
*  void
*---------------------------------------------------------------------------*/
void positiveRamp(void);

/*
******************************************************************************
* @FUNCTION
*  negativeRamp
*------------------------------------------------------------------------------
* @Description
*  Generates a negative rising ramp wave on the port 2, which is connected to a
*  DAC configured on the autorun mode. The wave has lenght of 0.5 ms and its
*  amplitude is the half of the DAC reference voltage. This implementation does
*  not take into account the DAC conversion delay.
*-----------------------------------------------------------------------------
* @Param
*  void
*-----------------------------------------------------------------------------
* @Returns
*  void
*---------------------------------------------------------------------------*/
void negativeRamp(void);

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

	while(1){

		positiveRamp();
		delay_ms(1);
		negativeRamp();
		delay_ms(1);
	}
}

/* partA.c#delay_ms */
void delay_ms(unsigned char delay){

	TMOD = TMOD & 0xF0;
	TMOD = TMOD | 0x01;
	TH0  = (65536 - delay*1000) >> 8;
	TL0  = 65536 - delay*1000;
	TR0  = TRUE;
	while(!TF0);
	TR0 = FALSE;
	TF0 = FALSE;
}

/* partA.c#positiveRamp */
void positiveRamp(void){

	__asm
	MOV	A,#0xFF
LOOPP:	INC	A
	MOV	P2,A
	CJNE	A,#0x80,LOOPP
	__endasm;
}

/* partA.c#negativeRamp */
void negativeRamp(void){

	__asm
	MOV	A,#0x80
LOOPN:	DEC	A
	MOV	P2,A
	CJNE	A,#0x00,LOOPN
	__endasm;
}
