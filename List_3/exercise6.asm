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
;  List: #3
;  Ex. : #6
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
	BASE		EQU	00H
	EXPONENT	EQU	01H
;*******************************************************************************

;*******************************************************************************
; @CODE
;  Main code
;------------------------------------------------------------------------------
	ORG	0
	MOV	BASE,#02H
	MOV	EXPONENT,#07H
	CLR	A
	ACALL	POWER
	SJMP	$
;*******************************************************************************

;*******************************************************************************
; @ROUTINE
;  POWER
;------------------------------------------------------------------------------
; @Description
;  Performs a exponentiation operation between two numbers: the base and the
;  exponent using recursion.
;------------------------------------------------------------------------------
; @Precondition
;  A:  Must be free to be used and must be 0 before calling the routine
;  R0: The base number constant must be defined on this register
;  R1: The exponent number constant must be defined on this register
;------------------------------------------------------------------------------
; @Param
;  BASE:     The exponentiation base number
;  EXPONENT: The exponentiation exponent number
;------------------------------------------------------------------------------
; @Returns
;  P1:   The BASE to the power of EXPONENT
;  P2.0: The carry overflow flag
;------------------------------------------------------------------------------
POWER:	DEC	R1
	CJNE	R1,#00H,NEXT
	MOV	P1,A
	RET
NEXT:	CLR	C
	MOV	B,BASE
	CJNE	A,#00H,MULT
	MOV	A,BASE
MULT:	MUL	AB
	ORL	C,P2.0
	ACALL	POWER
	RET
;*******************************************************************************
	END
