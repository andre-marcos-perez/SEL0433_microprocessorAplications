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
* @HEADER_GUARD
*  Pre-processor header guard opening conditional statement
*---------------------------------------------------------------------------*/
#ifndef SERIAL_H
#define	SERIAL_H

/*
******************************************************************************
* @LIBRARY
*  Dependency library
*---------------------------------------------------------------------------*/
#ifndef MCU
#include <at89x52.h>
#endif

/*
******************************************************************************
* @FUNCTION
*  serial_ini
*------------------------------------------------------------------------------
* @Description
*  Configures the serial in the following configuration: 9600,8,N,1 or a baud
*  rate of 9600 bits per second, ...
*-----------------------------------------------------------------------------
* @Param
*  void
*-----------------------------------------------------------------------------
* @Returns
*  void
*---------------------------------------------------------------------------*/
void serial_ini(void);

/*
******************************************************************************
* @FUNCTION
*  serial_getChar
*------------------------------------------------------------------------------
* @Description
*  Returns the received char stored on the serial reception buffer (SBUF).
*-----------------------------------------------------------------------------
* @Param
*  void
*-----------------------------------------------------------------------------
* @Returns
*  receivedChar: The received character stored on the reception buffer (SBUF)
*---------------------------------------------------------------------------*/
unsigned char serial_getChar(void);

#endif