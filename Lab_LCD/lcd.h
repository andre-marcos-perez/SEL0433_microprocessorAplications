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
#ifndef LCD_H
#define	LCD_H

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
*  lcd_ini
*------------------------------------------------------------------------------
* @Description
*  Initializes the lcd display with the following configuration: 2 lines, 8 or 4
*  bits, 5x7 char matrix, tuns display on, turns cursor on and enable its movement
*  from left to right.
*-----------------------------------------------------------------------------
* @Param
*  mode: the lcd bit mode, 0 for 8 bits (default) and 1 for 4 bits.
*-----------------------------------------------------------------------------
* @Returns
*  void
*---------------------------------------------------------------------------*/
void lcd_ini(unsigned char mode);

/*
******************************************************************************
* @FUNCTION
*  lcd_wrt
*------------------------------------------------------------------------------
* @Description
*  Sends a data to be written on the lcd.
*-----------------------------------------------------------------------------
* @Preconditions
*  To work properly, lcd#lcd_ini must have been called previously at least once
*-----------------------------------------------------------------------------
* @Param
*  data: The data to be written
*-----------------------------------------------------------------------------
* @Returns
*  void
*---------------------------------------------------------------------------*/
void lcd_wrt(unsigned char data);

/*
******************************************************************************
* @FUNCTION
*  lcd_cmd
*------------------------------------------------------------------------------
* @Description
*  Sends a command to the lcd.
*-----------------------------------------------------------------------------
* @Param
*  data: The command to be sent
*-----------------------------------------------------------------------------
* @Returns
*  void
*---------------------------------------------------------------------------*/
void lcd_cmd(unsigned char data);

/*
******************************************************************************
* @FUNCTION
*  lcd_pos
*------------------------------------------------------------------------------
* @Description
*  Moves the cursor to a specific position.
*-----------------------------------------------------------------------------
* @Param
*  pos: The display position where the cursor should put the next character.
*-----------------------------------------------------------------------------
* @Returns
*  void
*---------------------------------------------------------------------------*/
void lcd_pos(unsigned char pos);

/*
******************************************************************************
* @FUNCTION
*  lcd_clr
*------------------------------------------------------------------------------
* @Description
*  Clears the display and returns the cursor to home position.
*-----------------------------------------------------------------------------
* @Param
*  void
*-----------------------------------------------------------------------------
* @Returns
*  void
*---------------------------------------------------------------------------*/
void lcd_clr(void);

/*
******************************************************************************
* @FUNCTION
*  lcd_del
*------------------------------------------------------------------------------
* @Description
*  Clears the lcd position imediatly behind the cursor's current position.
*-----------------------------------------------------------------------------
* @Preconditions
*  To work properly, lcd#lcd_ini must have been called previously at least once
*-----------------------------------------------------------------------------
* @Param
*  void
*-----------------------------------------------------------------------------
* @Returns
*  void
*---------------------------------------------------------------------------*/
void lcd_del(void);

/*
******************************************************************************
* @FUNCTION
*  lcd_wait
*------------------------------------------------------------------------------
* @Description
*  Generates a delay between 1 and 65 micro seconds.
*-----------------------------------------------------------------------------
* @Preconditions
*  Timer 0 must be free to be used.
*-----------------------------------------------------------------------------
* @Param
*  time_ms: The delay in micro seconds
*-----------------------------------------------------------------------------
* @Returns
*  void
*---------------------------------------------------------------------------*/
void lcd_wait(unsigned char time_ms);

#endif