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
* @Class
*  Class: #1
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
#include <8052.h>

/*
******************************************************************************
* @CONSTANT
*  Code's constants
*---------------------------------------------------------------------------*/
#define TRUE	1
#define FALSE	0
#define STR	"UNIVERSITY OF SAO PAULO AT ENGINEERING SCHOOL OF SAO CARLOS$"

/*
;*******************************************************************************
; @INTERRUPTION
;  isr_serial
;------------------------------------------------------------------------------
; @Description
;  Interruption service routine to check if a character received from uart is
;  the ASCII code for the letter P. If true, sends through uart a message stored
;  in the internal rom, otherwise, returns.
;------------------------------------------------------------------------------
; @Param
;  Void
;------------------------------------------------------------------------------
; @Returns
;  Void
;----------------------------------------------------------------------------*/
void isr_serial(void) __interrupt(4);

/*
******************************************************************************
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

	TMOD = 0x20;
	TH1  = 0xFD;
	TL1  = 0xFD;
	SCON = 0x50;
	TR1  = TRUE;
	ES = TRUE;
	EA = TRUE;
	while(TRUE);
}

/* serialC.c#isr_serial */
void isr_serial(void) __interrupt(4){

	if(RI){

		RI = FALSE;
		if(SBUF == 'P'){

			unsigned char index;
			for(index=0 ; *(STR + index) != '$' ; index++){

				SBUF = *(STR + index);
				while(!TI);
				TI = FALSE;
			}
		}
	}
	else{

		TI = FALSE;
	}
}
