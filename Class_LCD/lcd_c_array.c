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
*  Class: #2
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
#define LCD_DAT	P0
#define LCD_EN	P3_7
#define LCD_RS	P3_6
#define LCD_RW	P3_5

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
void delay_ms(unsigned char delay);

/*
******************************************************************************
* @FUNCTION
*  lcd_wrt
*------------------------------------------------------------------------------
* @Description
*  Sends a data to be written on the lcd.
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
*  cmd: The command to be sent
*-----------------------------------------------------------------------------
* @Returns
*  void
*---------------------------------------------------------------------------*/
void lcd_cmd(unsigned char cmd);

/*
******************************************************************************
* @FUNCTION
*  lcd_init
*------------------------------------------------------------------------------
* @Description
*  Initializes the lcd display in the following configuration: 2 lines, 8 bits,
*  5x7 char matrix, tuns display on, turns cursor on and enable its movement
*  from left to right.
*-----------------------------------------------------------------------------
* @Param
*  void
*-----------------------------------------------------------------------------
* @Returns
*  void
*---------------------------------------------------------------------------*/
void lcd_init(void);

/*
******************************************************************************
* @FUNCTION
*  lcd_clr
*------------------------------------------------------------------------------
* @Description
*  Clears the display and returns the cursor to the home position.
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
*  lcd_pos
*------------------------------------------------------------------------------
* @Description
*  Moves the cursor to a specific position.
*-----------------------------------------------------------------------------
* @Param
*  pos: The display position where the cursor should put the next character,
*	according to its mapping.
*-----------------------------------------------------------------------------
* @Returns
*  void
*---------------------------------------------------------------------------*/
void lcd_pos(unsigned char pos);

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

  unsigned char index;
  unsigned char string[] = "HELLO WORLD!";

	lcd_init();
	lcd_clr();
  
	for(index=0 ; string[index] != 0 ; index++){

		if(string[index] == ' '){

			lcd_pos(0x4A);
		}
		else{

			lcd_wrt(string[index]);
		}
	}

	while(TRUE);
}

/* aula2.c#delay_ms */
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

/* aula2.c#lcd_wrt */
void lcd_wrt(unsigned char data){

	LCD_RS = TRUE;
	LCD_DAT = data;
	LCD_EN = TRUE;
	LCD_EN = FALSE;
	delay_ms(2);
}

/* aula2.c#lcd_cmd */
void lcd_cmd(unsigned char cmd){

	LCD_RS = FALSE;
	LCD_DAT = cmd;
	LCD_EN = TRUE;
	LCD_EN = FALSE;
	delay_ms(2);
}

/* aula2.c#lcd_init */
void lcd_init(void){

	delay_ms(15);
	LCD_RW = FALSE;
	lcd_cmd(0x38);
	lcd_cmd(0x0E);
	lcd_cmd(0x06);
}

/* aula2.c#lcd_clr */
void lcd_clr(void){

	lcd_cmd(0x01);
}

/* aula2.c#lcd_pos */
void lcd_pos(unsigned char pos){

	lcd_cmd(pos + 0x80);
}
