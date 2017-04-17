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
;  Ex. : # 1
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
; @CODE
;  Main code
;------------------------------------------------------------------------------
	ORG	0
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
;  Generates a delay of approximately 1 second (999ms and 245μs) by decrementing
;  three registers with defined values plus the time to switch context. These
;  values were calculated considering a 12Mhz crystal by the following equation:
;  delay(μs)=(((2R5)+4))R6+3))R7+3. The μController does not perfom any other
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
DELAY_1_SECOND:
	MOV	R5,#008H
LOOP_1:	MOV	R6,#0F3H
LOOP_0:	MOV	R7,#0FFH
	NOP
	DJNZ	R7,$
	DJNZ	R6,LOOP_0
	DJNZ	R5,LOOP_1
	RET
;*******************************************************************************
	END
