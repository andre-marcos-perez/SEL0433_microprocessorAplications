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
#include "lcd.h"

/*
******************************************************************************
* @CONSTANT
*  Code's constants
*---------------------------------------------------------------------------*/
#define TRUE	1
#define FALSE	0
#define _4_BITS	1
#define	_8_BITS	0
#define LCD_MSN	P0
#define LCD_LSN	P2
#define LCD_RS	P0_0
#define LCD_RW	P0_1
#define LCD_EN	P0_2

/*
******************************************************************************
* @FUNCTION
*  lcd_send
*------------------------------------------------------------------------------
* @Description
*  Sends a data or command to lcd according to its configured mode
*-----------------------------------------------------------------------------
* @Param
*  type: the data type, 0 for commands and 1 for data to be written.
*  data: the command or data to be written.
*-----------------------------------------------------------------------------
* @Returns
*  void
*---------------------------------------------------------------------------*/
static void lcd_send(unsigned char type, unsigned char data);

/*
******************************************************************************
* @VARIABLE
*  Code's variables
*---------------------------------------------------------------------------*/
static unsigned char lcd_mode;
static unsigned char lcd_cursor;

/* lcd.h#lcd_ini */
void lcd_ini(unsigned char mode){

	lcd_wait(15);
	LCD_RW = FALSE;
	if(mode == _4_BITS){

		lcd_cmd(0x28);
		lcd_mode = _4_BITS;
	}
	else{

		lcd_cmd(0x38);
	}

	lcd_cmd(0x0E);
	lcd_cmd(0x06);
	lcd_cmd(0x01);
}

/* lcd.h#lcd_wrt */
void lcd_wrt(unsigned char data){

	switch(lcd_cursor){

		case 0x10:{

			lcd_cursor = 0x40;
			lcd_pos(lcd_cursor);
			break;

		}
		case 0x3F:{

			lcd_cursor = 0xF;
			lcd_pos(lcd_cursor);
			break;
		}
		case 0x50:{

			lcd_pos(--lcd_cursor);
			break;
		}
	}

	lcd_send(1,data);
	lcd_cursor++;
}

/* lcd.h#lcd_cmd */
void lcd_cmd(unsigned char data){

	lcd_send(0,data);
}

/* lcd.h#lcd_pos */
void lcd_pos(unsigned char pos){

	lcd_cmd(pos + 0x80);
}

/* lcd.h#lcd_clr */
void lcd_clr(void){

	lcd_cmd(0x01);
}

/* lcd.h#lcd_del */
void lcd_del(void){

	if(lcd_cursor != 0x00){

		lcd_pos(--lcd_cursor);
	}

	lcd_wrt(0xFE);
	lcd_pos(--lcd_cursor);
}

/* lcd.h#lcd_wait */
void lcd_wait(unsigned char time_ms){

	TMOD = TMOD & 0xF0;
	TMOD = TMOD | 0x01;
	TH0  = (65536 - time_ms*1000) >> 8;
	TL0  = (65536 - time_ms*1000);
	TR0  = TRUE;
	while(!TF0);
	TR0 = FALSE;
	TF0 = FALSE;
}

/* lcd.c#lcd_send */
static void lcd_send(unsigned char type, unsigned char data){

	LCD_RS = type;
	LCD_MSN = (LCD_MSN & 0x0F) | (data & 0xF0);
	if(lcd_mode == _4_BITS){

		LCD_EN = TRUE;
		LCD_EN = FALSE;
		lcd_wait(2);
		LCD_MSN = (LCD_MSN & 0x0F) | ((data << 4) & 0xF0);
	}
	else{

		LCD_LSN = (LCD_LSN & 0xF0) | (data & 0x0F);
	}

	LCD_EN = TRUE;
	LCD_EN = FALSE;
	lcd_wait(2);
}