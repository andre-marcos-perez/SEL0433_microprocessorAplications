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
;  Ex. : #3
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
	MSG1_SIZE	EQU	60H
	MSG2_SIZE	EQU	61H
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
	MOV	R1,#MSG2_SIZE
	MOV	DPTR,#MSG2
	LCALL	READ_STRING
	SJMP	$
MSG1: 	DB 'MCU8051','$'
MSG2: 	DB 'SEL0433-2017',24h
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
	END
