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
;  Ex. : # 4
;  Part: # --
;------------------------------------------------------------------------------
; @AUTHOR
;  Name:  Andre Marcos Perez
;  Email: andre.marcos.perez@usp.br
;  #USP:  8006891
;*******************************************************************************

;*******************************************************************************
; @CONSTANT
;  Code's constants
;------------------------------------------------------------------------------
	BUFFER_HEAD	EQU	20H
	BUFFER_TAIL	EQU	BUFFER_HEAD + 11
;*******************************************************************************

;*******************************************************************************
; @VARIABLE
;  Code's variables
;------------------------------------------------------------------------------
	MOTOR_STEPS_QTD	EQU	1FH
	MOTOR_DIRECTION	BIT	P1.1
	MOTOR_CLOCK	BIT	P1.0
;*******************************************************************************

;*******************************************************************************
; @MACROS
;  Code's macros
;------------------------------------------------------------------------------
; @Description
;  Simulates one step on the stepper motor
;------------------------------------------------------------------------------
	MOTOR_STEP	MACRO
	SETB	MOTOR_CLOCK
	;	DELAY
	CLR	MOTOR_CLOCK
	ENDM
;*******************************************************************************

;*******************************************************************************
; @CODE
;  Main code
;------------------------------------------------------------------------------
	ORG	0
	LCALL	MAIN
	ORG	23H
	LCALL	ISR_SERIAL
	RETI
MAIN:	CLR	MOTOR_CLOCK
	MOV	TMOD,#20H
	MOV	TH1,#0FDH
	MOV	TL1,#0FDH
	MOV	SCON,#50H
	SETB	TR1
	SETB	ES
	SETB	EA
	MOV	R0,#BUFFER_HEAD
LOOP:	JNB	F0,$
	CLR	F0
	CLR	ES
	MOV	R0,#(BUFFER_HEAD + 0)
	LCALL	BUFFER_CHECK
	MOV	R0,#(BUFFER_HEAD + 3)
	LCALL	BUFFER_CHECK
	MOV	R0,#(BUFFER_HEAD + 6)
	LCALL	BUFFER_CHECK
	MOV	R0,#(BUFFER_HEAD + 9)
	LCALL	BUFFER_CHECK
	LCALL	BUFFER_FLUSH
	SETB	ES
	SJMP	LOOP
;*******************************************************************************

;*******************************************************************************
; @ROUTINE
;  BUFFER_CHECK
;------------------------------------------------------------------------------
; @Description
;  Checks whether the three next ASCII chars present on the BUFFER are valid or
;  not. If at least one char is invalid, it skips the entire command, else, calls
;  a routine to perform the valid command.
;------------------------------------------------------------------------------
; @Param
;  R0:	Is the pointer for the 1st char of the command sequence stored on BUFFER
;------------------------------------------------------------------------------
; @Returns
;  Void
;------------------------------------------------------------------------------
BUFFER_CHECK:
	CJNE	@R0,#00H,CHECK_MSB
	SJMP	ERROR
CHECK_MSB:
	CJNE	@R0,#30H,CHECK_MSB_A
CHECK_MSB_A:
	JC	ERROR
	CJNE	@R0,#3AH,CHECK_MSB_B
CHECK_MSB_B:
	JNC	ERROR
	CLR	C
	INC	R0
	CJNE	@R0,#00H,CHECK_LSB
	SJMP	ERROR
CHECK_LSB:
	CJNE	@R0,#30H,CHECK_LSB_A
CHECK_LSB_A:
	JC	ERROR
	CJNE	@R0,#3AH,CHECK_LSB_B
CHECK_LSB_B:
	JNC	ERROR
	INC	R0
	CJNE	@R0,#'A',CHECK_CHAR_H
	DEC	R0
	DEC	R0
	CLR	MOTOR_DIRECTION
	LCALL	MOTOR_START
	RET
CHECK_CHAR_H:
	CJNE	@R0,#'H',ERROR
	DEC	R0
	DEC	R0
	SETB	MOTOR_DIRECTION
	LCALL	MOTOR_START
ERROR:	RET
;*******************************************************************************

;*******************************************************************************
; @ROUTINE
;  BUFFER_FLUSH
;------------------------------------------------------------------------------
; @Description
;  Clears the BUFFER.
;------------------------------------------------------------------------------
; @Precondition
;  BUFFER_HEAD:	The first BUFFER element position on the ram must be defined here
;  BUFFER_TAIL:	The last BUFFER element position on the ram must be defined here
;------------------------------------------------------------------------------
; @Param
;  Void
;------------------------------------------------------------------------------
; @Returns
;  Void
;------------------------------------------------------------------------------
BUFFER_FLUSH:
	MOV	R0,#BUFFER_TAIL
FLUSH:	MOV	@R0,#00H
	DEC	R0
	CJNE	R0,#BUFFER_HEAD,FLUSH
	MOV	@R0,#00H
	RET
;*******************************************************************************

;*******************************************************************************
; @ROUTINE
;  MOTOR_START
;------------------------------------------------------------------------------
; @Description
;  Perfoms the command sequence stored on the BUFFER. It makes the stepper motor
;  performs as many steps as the user input. Also, for each step, it sends the
;  number of steps performed and its direction to a monitor via serial.
;------------------------------------------------------------------------------
; @Precondition
;  R2:	Must be free to be used.
;------------------------------------------------------------------------------
; @Param
;  R0:	Is the pointer for the 1st char of the command sequence stored on BUFFER
;------------------------------------------------------------------------------
; @Returns
;  Void
;------------------------------------------------------------------------------
MOTOR_START:
	LCALL	NUMBER_ASCII_TO_HEX
	MOV	MOTOR_STEPS_QTD,A
	CLR	A
STEP:	ADD	A,#01H
	DA	A
	MOV	R2,A
	LCALL	NUMBER_HEX_TO_ASCII
	MOV	SBUF,A
	JNB	TI,$
	CLR	TI
	MOV	A,R1
	MOV	SBUF,A
	JNB	TI,$
	CLR	TI
	MOV	SBUF,@R0
	JNB	TI,$
	CLR	TI
	MOTOR_STEP
	MOV	A,R2
	CJNE	A,MOTOR_STEPS_QTD,STEP
	RET
;*******************************************************************************

;*******************************************************************************
; @ROUTINE
;  NUMBER_ASCII_TO_HEX
;------------------------------------------------------------------------------
; @Description
;  Converts a two digit ASCII number into one digit hexadecimal number.
;------------------------------------------------------------------------------
; @Precondition
;  R1:	Must be free to be used.
;------------------------------------------------------------------------------
; @Param
;  @(R1+0): Is the pointer for the MSB two digit ASCII number to be converted.
;  @(R1+1): Is the pointer for the LSB two digit ASCII number to be converted.
;------------------------------------------------------------------------------
; @Returns
;  A: Is the one digit hexadecimal number converted.
;------------------------------------------------------------------------------
NUMBER_ASCII_TO_HEX:
	MOV	A,@R0
	SUBB	A,#30H
	SWAP	A
	MOV	R1,A
	INC	R0
	MOV	A,@R0
	SUBB	A,#30H
	ORL	A,R1
	INC	R0
	RET
;*******************************************************************************

;*******************************************************************************
; @ROUTINE
;  NUMBER_HEX_TO_ASCII
;------------------------------------------------------------------------------
; @Description
;  Converts an one digit hexadecimal number into two digit ASCII number.
;------------------------------------------------------------------------------
; @Param
;   A:	Is the one digit hexadecimal number to be convertd.
;------------------------------------------------------------------------------
; @Returns
;   A:	Is the MSB two digit ASCII number converted.
;  R1:	Is the LSB two digit ASCII number converted.
;------------------------------------------------------------------------------
NUMBER_HEX_TO_ASCII:
	MOV	R1,A
	ANL	A,#0FH
	ADD	A,#30H
	XCH	A,R1
	SWAP	A
	ANL	A,#0FH
	ADD	A,#30H
	RET
;*******************************************************************************

;*******************************************************************************
; @INTERRUPTION
;  ISR_SERIAL
;------------------------------------------------------------------------------
; @Description
;  Checks whether the buffer is full or the 'A' ASCII char (enter key) was received
;  via serial. If the buffer is full, do nothing. If the 'A' char was received,
;  changes the F0 flag status, making the main program to check the buffer entries
;  and control the stepper motor, eventually. If neither the buffer is full nor the
;  A char was received, enqueues the data received on the buffer.
;------------------------------------------------------------------------------
; @Precondition
;  BUFFER_TAIL:	The last BUFFER element position on the ram must be defined here
;------------------------------------------------------------------------------
; @Param
;  Void
;------------------------------------------------------------------------------
; @Returns
;  Void
;------------------------------------------------------------------------------
ISR_SERIAL:
	CLR	RI
	MOV	A,SBUF
	CJNE	A,#0AH,BUFFER_FULL
	SETB	F0
	RET
BUFFER_FULL:
	CJNE	R0,#(BUFFER_TAIL+1),BUFFER_ENQUEUE
	RET
BUFFER_ENQUEUE:
	MOV	@R0,A
	INC	R0
	RET
;*******************************************************************************
	END
