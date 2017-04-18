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
;  List: #2
;  Ex. : #4
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
	STRING_TERMINATOR	EQU	'$'
;*******************************************************************************

;*******************************************************************************
; @VARIABLE
;  Code's variables
;------------------------------------------------------------------------------
	STRING_MSG	EQU	30H
	STRING_STR	EQU	48H
	MSG1_SIZE	EQU	60H
	MSG2_SIZE	EQU	61H
	STR1_SIZE	EQU	62H
	STR2_SIZE	EQU	63H
;*******************************************************************************

;*******************************************************************************
; @CODE
;  Main code
;------------------------------------------------------------------------------
	ORG	0
	MOV	R0,#STRING_MSG
	MOV	R1,#MSG1_SIZE
	MOV	DPTR,#MSG1
	LCALL	READ_STRING
	MOV	R0,#STRING_STR
	MOV	R1,#STR1_SIZE
	MOV	DPTR,#STR1
	LCALL	READ_STRING
	MOV	R4,#STRING_MSG
	MOV	R5,#MSG1_SIZE
	MOV	R6,#STRING_STR
	MOV	R7,#STR1_SIZE
	LCALL	EQUALS
	SETB	P1.0
	JB	F0,MSG1_EQUALS_STR1
	CLR	P1.0
MSG1_EQUALS_STR1:
	MOV	R0,#STRING_MSG
	MOV	R1,#MSG2_SIZE
	MOV	DPTR,#MSG2
	LCALL	READ_STRING
	MOV	R0,#STRING_STR
	MOV	R1,#STR2_SIZE
	MOV	DPTR,#STR2
	LCALL	READ_STRING
	MOV	R4,#STRING_MSG
	MOV	R5,#MSG2_SIZE
	MOV	R6,#STRING_STR
	MOV	R7,#STR2_SIZE
	LCALL	EQUALS
	SETB	P1.7
	JB	F0,MSG2_EQUALS_STR2
	CLR	P1.7
MSG2_EQUALS_STR2:
	SJMP	$
MSG1: 	DB 'WRONG_STRING','$'
MSG2: 	DB 'WRONG_STRING',24h
STR1: 	DB 'MCU8051','$'
STR2: 	DB 'SEL0433-2017',24h
;*******************************************************************************

;*******************************************************************************
; @ROUTINE
;  READ_STRING
;------------------------------------------------------------------------------
; @Description
;  Moves sequence os characters stored on the rom address pointed by DPTR to the
;  internal ram address pointed by R0. Also, stores its size on the internal ram
;  address pointed by R1.
;------------------------------------------------------------------------------
; @Precondition
;  STRING_TERMINATOR: The string terminator must be defined on this constant.
;------------------------------------------------------------------------------
; @Param
;  DPTR: Pointer for the rom address where the string's first character is stored
;  R0  : Pointer for the internal ram address where the string's first character
;        will be stored
;  R1  : Pointer for the internal ram address where the string size will be stored
;------------------------------------------------------------------------------
; @Returns
;  Void
;------------------------------------------------------------------------------
READ_STRING:
	CLR	A
	MOVC	A,@A+DPTR
	MOV	@R0,A
	INC	DPTR
	INC	R0
	INC	@R1
	CJNE	A,#STRING_TERMINATOR,READ_STRING
	RET
;*******************************************************************************

;*******************************************************************************
; @ROUTINE
;  EQUALS
;------------------------------------------------------------------------------
; @Description
;  Compares a strings with a reference string and returns whether they are equal
;  or not.
;------------------------------------------------------------------------------
; @Precondition
;  R0: Must be free to be used
;  R1: Must be free to be used
;  F0: Must be free to be used
;------------------------------------------------------------------------------
; @Param
;  R4: The internal ram address of the first character of the string to be compared
;  R5: The size of the string to be compared
;  R6: The internal ram address of the first character of the reference string
;  R7: The size of the reference string
;------------------------------------------------------------------------------
; @Returns
;  F0: Returns 1 if the string is equal to the reference string, otherwise,
;      returns 0
;------------------------------------------------------------------------------
EQUALS:
	MOV	A,R5
	MOV	R0,A
	MOV	A,R7
	MOV	R1,A
	MOV	A,@R0
	SUBB	A,@R1
	CJNE	A,#00H,STRINGS_ARENT_EQUAL
	SETB	F0
	MOV	A,R4
	MOV	R0,A
	MOV	A,R6
	MOV	R1,A
LOOP:	CLR	C
	MOV	A,@R0
	SUBB	A,@R1
	CJNE	A,#00H,STRINGS_ARENT_EQUAL
	MOV	A,@R0
	INC	R0
	INC	R1
	CJNE	A,#STRING_TERMINATOR,LOOP
	RET
STRINGS_ARENT_EQUAL:
	CLR	F0
	RET
;*******************************************************************************
	END

