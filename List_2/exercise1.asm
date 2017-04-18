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
;  Ex. : #1
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
	EXTERNAL_RAM_ADDRESS_EVEN_NUMBERS	EQU	60H
	INTERNAL_RAM_ADDRESS_EVEN_NUMBERS	EQU	60H
;*******************************************************************************

;*******************************************************************************
; @VARIABLE
;  Code's variables
;------------------------------------------------------------------------------
	NUMBER	EQU	20H
;*******************************************************************************

;*******************************************************************************
; @CODE
;  Main code
;------------------------------------------------------------------------------
	ORG	0
	MOV	DPTR,#EXTERNAL_RAM_ADDRESS_EVEN_NUMBERS
	MOV	R0,#INTERNAL_RAM_ADDRESS_EVEN_NUMBERS
	MOV	R1,#NUMBER
	MOV	NUMBER,#20H
LOOP:	JB	NUMBER.0,NUMBER_IS_ODD
	MOV	A,@R1
	MOV	@R0,A
	MOVX	@DPTR,A
	INC	R0
	INC	DPTR
NUMBER_IS_ODD:
	INC	NUMBER
	CJNE	@R1,#41H,LOOP
	SJMP	$
;*******************************************************************************
	END
