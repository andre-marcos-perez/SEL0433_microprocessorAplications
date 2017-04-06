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
;  List: #1
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
	INTERNAL_RAM_ADDRESS_LOWEST_RESISTANCE	EQU	20H
	INTERNAL_RAM_ADDRESS_HIGHEST_RESISTANCE	EQU	30H
	EXTERNAL_RAM_ADDRESS_LOWEST_RESISTANCE	EQU	20H
	EXTERNAL_RAM_ADDRESS_HIGHEST_RESISTANCE	EQU	30H
;*******************************************************************************

;*******************************************************************************
; @CODE
;  Main code
;------------------------------------------------------------------------------
	ORG	0
	MOV	R0,#INTERNAL_RAM_ADDRESS_LOWEST_RESISTANCE
	MOV	R1,#INTERNAL_RAM_ADDRESS_HIGHEST_RESISTANCE
	MOV	DPTR,#DADOS
	LCALL 	COMPARE_RESISTOR
	INC	DPTR
	LCALL 	COMPARE_RESISTOR
	INC	DPTR
	LCALL 	COMPARE_RESISTOR
	MOV	A,@R0
	MOV	DPTR,#EXTERNAL_RAM_ADDRESS_LOWEST_RESISTANCE
	MOVX	@DPTR,A
	MOV	A,@R1
	MOV	DPTR,#EXTERNAL_RAM_ADDRESS_HIGHEST_RESISTANCE
	MOVX	@DPTR,A
	SJMP	$
DADOS:
	DB	150D, 220D, 033D
	;DB	220D, 047D, 180D
;*******************************************************************************

;*******************************************************************************
; @ROUTINE
;  COMPARE_RESISTOR
;------------------------------------------------------------------------------
; @Description
;  Compare a 1 byte resistance value stored on program memory with another two
;  1 byte resistance values pointed by R0 and R1 on internal data memory. If
;  higher, swap with the value pointed by R0 and if lower, swap with the value
;  pointed by R1. Otherwise, do nothing.
;------------------------------------------------------------------------------
; @Precondition
;  R0: Must be pointing to address on internal data memory where the lowest
;      resistance is stored
;  R1: Must be pointing to address on internal data memory where the highest
;      resistance is stored
;------------------------------------------------------------------------------
; @Param
;  DPTR: The address on program memory where the resistance value is stored
;------------------------------------------------------------------------------
; @Returns
;  Void
;------------------------------------------------------------------------------
COMPARE_RESISTOR:
	CLR	A
	MOVC	A,@A+DPTR
	PUSH	ACC
	SUBB	A,@R1
	JNC	A_IS_HIGHER
	CJNE	@R0,#00H,CONTINUE
	SJMP	A_IS_LOWER
CONTINUE:
	CLR	C
	POP	ACC
	PUSH	ACC
	SUBB	A,@R0
	JC	A_IS_LOWER
	POP	ACC
	RET
A_IS_HIGHER:
	POP	ACC
	XCH	A,@R1
	RET
A_IS_LOWER:
	POP	ACC
	XCH	A,@R0
	RET
;*******************************************************************************
	END
