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
;  Ex. : #5
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
	EXTERNAL_RAM_ADDRESS_CURRENT_MSB	EQU	1000H
	INTERNAL_RAM_ADDRESS_LITTLE_ENDIAN_MSB	EQU	20H
;*******************************************************************************

;*******************************************************************************
; @CODE
;  Main code
;------------------------------------------------------------------------------
	ORG	0
	MOV	DPTR,#(EXTERNAL_RAM_ADDRESS_CURRENT_MSB+2D)
	MOV	R1,#(INTERNAL_RAM_ADDRESS_LITTLE_ENDIAN_MSB+0D)
	MOV	R0,#07H
LOOP:   MOV	C,F0
	MOVX	A,@DPTR
	ADDC	A,@R0
	MOV	F0,C
	MOV	@R1,A
	DEC	DPL
	INC	R1
	DEC	R0
	CJNE	R1,#(INTERNAL_RAM_ADDRESS_LITTLE_ENDIAN_MSB+3D),LOOP
	SJMP	$
;*******************************************************************************
	END
