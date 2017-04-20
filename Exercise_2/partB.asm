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
;  Part: # B
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
	MOTOR_CONTROL_0	BIT	P2.1
	MOTOR_CONTROL_1	BIT	P2.7
;*******************************************************************************

;*******************************************************************************
; @MACROS
;  Code's macros
;------------------------------------------------------------------------------
; @Description
;  Stops motor
;------------------------------------------------------------------------------
	MOTOR_STOP	MACRO
	CLR	MOTOR_CONTROL_0
	CLR	MOTOR_CONTROL_1
	ENDM
;------------------------------------------------------------------------------
; @Description
;  Turns motor clockwise
;------------------------------------------------------------------------------
	MOTOR_TURN_CLOCKWISE	MACRO
	SETB	MOTOR_CONTROL_0
	CLR	MOTOR_CONTROL_1
	ENDM
;------------------------------------------------------------------------------
; @Description
;  Turns motor counter clockwise
;------------------------------------------------------------------------------
	MOTOR_TURN_COUNTERCLOCKWISE	MACRO
	CLR	MOTOR_CONTROL_0
	SETB	MOTOR_CONTROL_1
	ENDM
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
	LJMP	MAIN
	ORG 	03H
	LJMP	ISR_INT0_SENSOR
	ORG	0BH
	LJMP	ISR_TIMER0
MAIN:	MOV	TMOD,#01H
	LOAD_TIMER0_20HZ
	SETB	ET0
	SETB	PT0
	SETB	IT0
	SETB	EX0
	SETB	EA
	MOTOR_TURN_CLOCKWISE
	SJMP	$
;*******************************************************************************

;*******************************************************************************
; @ROUTINE
;  DELAY_5_SECONDS
;------------------------------------------------------------------------------
; @Description
;  Generates a delay of approximately 5 seconds (5s and 159μs) by decrementing
;  three registers with defined values plus the time to switch context. These
;  values were calculated considering a 12Mhz crystal by the following equation:
;  delay(μs)=(((2R5)+4))R6+3))R7+3. The microntroller does not perfom any other
;  operation while counting unless interrupted by a interruption service routine.
;------------------------------------------------------------------------------
; @Precondition
;  R5: Must be free to be used
;  R6: Must be free to be used
;  R7: Must be free to be used
;------------------------------------------------------------------------------
; @Param
;  Void
;------------------------------------------------------------------------------
; @Returns
;  Void
;------------------------------------------------------------------------------
DELAY_5_SECONDS:
	MOV	R0,#00H
	SETB	TR0
	CJNE	R0,#64H,$
	CLR	TR0
	RET
;*******************************************************************************

;*******************************************************************************
; @INTERRUPTION
;  ISR_INT0_SENSOR
;------------------------------------------------------------------------------
; @Description
;  Generates a delay of approximately 5 second by waiting a register to have a
;  value of 0x64 or 100. The routine starts the timer 0, which is configurated to
;  overflow at a rate of 20Hz and to increment the aforementioned register, thus
;  making the desired delay (100 times 20Hz is equal to 5 second). Stops the timer
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
ISR_INT0_SENSOR:
	MOTOR_STOP
	LCALL	DELAY_5_SECONDS
	JNB	F0,COUNTERCLOCKWISE_DIRECTION
	LCALL	DELAY_5_SECONDS
	MOTOR_TURN_CLOCKWISE
	CLR	F0
	RETI
COUNTERCLOCKWISE_DIRECTION:
	MOTOR_TURN_COUNTERCLOCKWISE
	SETB	F0
	RETI
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
