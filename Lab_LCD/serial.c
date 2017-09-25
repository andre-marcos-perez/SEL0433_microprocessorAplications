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
#include "serial.h"

/*
******************************************************************************
* @CONSTANT
*  Code's constants
*---------------------------------------------------------------------------*/
#define TRUE	1
#define FALSE	0

/* serial.h#serial_ini */
void serial_ini(void){

	TMOD = TMOD & 0x0F;
	TMOD = TMOD | 0x20;
	TH1  = 0xFD;
	TL1  = 0xFD;
	SCON = 0x50;
	TR1  = TRUE;
	ES = TRUE;
	EA = TRUE;
}

/* serial.h#serial_getChar */
unsigned char serial_getChar(void){

	unsigned char receivedChar;

	receivedChar = SBUF;
	return receivedChar;
}