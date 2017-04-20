;*******************************************************************************
; @INSTITUTION
;  University of Sao Paulo | Sao Carlos School of Engineering | SEL
;------------------------------------------------------------------------------
; @DISCIPLINE
;  Name: SEL0433 | Applications of Microprocessors I
;  Professor: Evandro Luis Linhari Rodrigues
;  Semester: 2017\01
;------------------------------------------------------------------------------
; @DEVELOPMENT
;  MCU:	Intel 8052
;  IDE: MCU 8051 v1.5.7
;  Compiler: IDE native assembler
;------------------------------------------------------------------------------
; @WARRANTY
;  Copyright (c) 2017 Andre Marcos Perez
;  The software is provided by "as is", without warranty of any kind, express or
;  implied, including but not limited to the warranties of merchantability,
;  fitness for a particular purpose and noninfringement. In no event shall the
;  authors or copyright holders be liable for any claim, damages or other
;  liability, whether in an action of contract, tort or otherwise, arising from,
;  out of or in connection with the software or the use or other dealings in the
;  software.
;------------------------------------------------------------------------------
; @EXERCISE
;  Ex. : # 2
;  Part: # A
;------------------------------------------------------------------------------
; @AUTHOR
;  Name:  Andre Marcos Perez
;  Email: andre.marcos.perez@usp.br
;  #USP:  8006891
;*******************************************************************************

;*******************************************************************************
; @VARIABLE
;  Code's variables
;------------------------------------------------------------------------------
	SWITCH_1	BIT	P3.5
	SWITCH_2	BIT	P3.6
	SWITCH_3	BIT	P3.7
	LED_1		BIT	P1.0
	LED_2		BIT	P1.1
	LED_3		BIT	P1.2
;*******************************************************************************

;*******************************************************************************
; @MACROS
;  Code's macros
;------------------------------------------------------------------------------
; @Description
;  Load timer 0 to overflow in 20hz
;------------------------------------------------------------------------------
	LOAD_TIMER0_20HZ	MACRO
	MOV	TH0,#03CH
	MOV	TL0,#0B0H
	ENDM
;*******************************************************************************

;*******************************************************************************
; @CODE
;  Main code
;------------------------------------------------------------------------------
	ORG	0
	SJMP	MAIN
	ORG	0BH
	LJMP	ISR_TIMER0
MAIN:	MOV	TMOD,#01H
	LOAD_TIMER0_20HZ
	SETB	ET0
	SETB	EA
CHECK_SWITCH_1:
	JNB	SWITCH_1,CHECK_SWITCH_2
	CPL	LED_1
	LCALL	DELAY_1_SECOND
	SJMP	CHECK_SWITCH_1
CHECK_SWITCH_2:
	JNB	SWITCH_2,CHECK_SWITCH_3
	CPL	LED_2
	LCALL	DELAY_1_SECOND
	SJMP	CHECK_SWITCH_2
CHECK_SWITCH_3:
	JNB	SWITCH_3,CHECK_SWITCH_1
	CPL	LED_1
	LCALL	DELAY_1_SECOND
	CPL	LED_1
	CPL	LED_3
	LCALL	DELAY_1_SECOND
	CPL	LED_3
	SJMP	CHECK_SWITCH_3
;*******************************************************************************

;*******************************************************************************
; @ROUTINE
;  DELAY_1_SECOND
;------------------------------------------------------------------------------
; @Description
;  Generates a delay of approximately 1 second by waiting a register to have a
;  value of 0x14 or 20. The routine starts the timer 0, which is configurated to
;  overflow at a rate of 20Hz and to increment the aforementioned register, thus
;  making the desired delay (20 times 20Hz is equal to 1 second). Stops the timer
;  before returning.
;------------------------------------------------------------------------------
; @Precondition
;  R0: Must be free to be used
;------------------------------------------------------------------------------
; @Param
;  Void
;------------------------------------------------------------------------------
; @Returns
;  Void
;------------------------------------------------------------------------------
DELAY_1_SECOND:
	MOV	R0,#00H
	SETB	TR0
	CJNE	R0,#14H,$
	CLR	TR0
	RET
;*******************************************************************************

;*******************************************************************************
; @INTERRUPTION
;  ISR_TIMER0
;------------------------------------------------------------------------------
; @Description
;  Increment register R0 and reload timer to overflow at a rate of 20Hz.
;------------------------------------------------------------------------------
; @Precondition
;  This function must be called on the properly interruption address
;  TMOD: Must be configured to put timer 0 to operate at mode 1
;   TR0: Must be set to let the timer 0 increment until it overflows
;   ET0: Must be set to enable timer 0 overflow interruption
;    EA: Must be set to enable interruptions
;------------------------------------------------------------------------------
; @Param
;  Void
;------------------------------------------------------------------------------
; @Returns
;  Void
;------------------------------------------------------------------------------
ISR_TIMER0:
	INC	R0
	LOAD_TIMER0_20HZ
	RETI
;*******************************************************************************
	END
