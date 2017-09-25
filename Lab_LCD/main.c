/*
*******************************************************************************
* @INSTITUTION
*  University of Sao Paulo | Sao Carlos School of Engineering | SEL
*------------------------------------------------------------------------------
* @DISCIPLINE
*  Name: SEL0337 | Applications of Microprocessors II
*  Professor: Evandro Luis Linhari Rodrigues
*  Semester: 2017\01
*------------------------------------------------------------------------------
* @DEVELOPMENT
*  MCU: Atmel AT89S52
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
* @LABORATORY
*  Practice: #1
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
#include "lcd.h"
#include "serial.h"

/*
******************************************************************************
* @CONSTANT
*  Code's constants
*---------------------------------------------------------------------------*/
#define DEL	0x7F
#define BS	0x08
#define TRUE	1
#define FALSE	0
#define _4_BITS	1
#define	_8_BITS	0

/*
;*******************************************************************************
; @INTERRUPTION
;  isr_serial
;------------------------------------------------------------------------------
; @Description
;  Serial interruption service routine that checks which character was received
;  from the keyboard, calling the approprieted lcd function.
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

	serial_ini();
	lcd_ini(_4_BITS);
	lcd_ini(_4_BITS);
	while(TRUE);
}

/* main.c#isr_serial */
void isr_serial(void) __interrupt(4){

	unsigned char keyboardChar;

	if(RI){

		RI = FALSE;
		keyboardChar = serial_getChar();
		switch(keyboardChar){

			case BS:{

				lcd_del();
				break;
			}
			case DEL:{

				lcd_clr();
				break;
			}
			default:{

				lcd_wrt(keyboardChar);
				break;
			}
		}
	}
}
