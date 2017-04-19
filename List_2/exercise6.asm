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
;  Ex. : #6
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
	EXTERNAL_RAM_ADDRESS_TABLE_BEGIN	EQU	5000H
	EXTERNAL_RAM_ADDRESS_TABLE_END		EQU	51FFH
	EXTERNAL_RAM_ADDRESS_COUNT_TABLE_BEGIN	EQU	00H
;*******************************************************************************

;*******************************************************************************
; @CODE
;  Main code
;------------------------------------------------------------------------------
	ORG	0
	MOV	R7,#EXTERNAL_RAM_ADDRESS_COUNT_TABLE_BEGIN
LOOP:	MOV	DPTR,#EXTERNAL_RAM_ADDRESS_TABLE_BEGIN
	LCALL	COUNT_OCCURRENCE
	MOV	A,R1
	MOV	DPH,#00H
	MOV	DPL,R7
	MOVX	@DPTR,A
	MOV	R1,#00H
	INC	R7
	INC	R0
	CJNE	R0,#00H,LOOP
	SJMP	$
;*******************************************************************************

;*******************************************************************************
; @ROUTINE
;  COUNT_OCCURRENCE
;------------------------------------------------------------------------------
; @Description
;  Count the occurrence of a value stored on register R0 in a table of values
;  stored on the external ram. Saves the number of occurrences on register R1.
;------------------------------------------------------------------------------
; @Precondition
;  EXTERNAL_RAM_ADDRESS_TABLE_END: The last element address of the table must be
;				   stored on this constant
;------------------------------------------------------------------------------
; @Param
;  DPTR: Pointer for the first element of the table stored on the external ram
;    R0: The value to be counted its occurrence on the table
;------------------------------------------------------------------------------
; @Returns
;    R1: The number of occurrences of the value stored on register R0
;------------------------------------------------------------------------------
COUNT_OCCURRENCE:
	MOVX	A,@DPTR
	XRL	A,R0
	CJNE	A,#00H,NOT_EQUAL
	INC	R1
NOT_EQUAL:
	INC	DPTR
	MOV	A,DPH
	CJNE	A,#HIGH(EXTERNAL_RAM_ADDRESS_TABLE_END),COUNT_OCCURRENCE
	MOV	A,DPL
	CJNE	A,#LOW(EXTERNAL_RAM_ADDRESS_TABLE_END),COUNT_OCCURRENCE
	RET
;*******************************************************************************
	END
