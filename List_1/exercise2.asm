;*******************************************************************************
; @INSTITUTION
;  University of Sao Paulo | Sao Carlos School of Engineering | SEL
;------------------------------------------------------------------------------
; @DISCIPLINE
;  Name: SEL0433 | Applications of Microprocessors I
;  Professor: Evandro Luis Linhari Rodrigues
;  Academic Period: 2017\01
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
;  Ex. : #2
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
	GRAN1	EQU	02H
	GRAN2	EQU	22H
	GRAN3	EQU	42H
	INTERNAL_RAM_ADDRESS_SUM_RESULT	   EQU	20H
	INTERNAL_RAM_ADDRESS_OVERFLOW_FLAG EQU	21H.0
;*******************************************************************************

;*******************************************************************************
; @CODE
;  Main code
;------------------------------------------------------------------------------
	ORG	0
	MOV	GRAN1,#04Fh
	MOV	GRAN2,#0D1H
	MOV	GRAN3,#0FAH
	ADD	A,GRAN1
	ADD	A,GRAN2
	JNB	OV,CONTINUE
	SETB	INTERNAL_RAM_ADDRESS_OVERFLOW_FLAG
CONTINUE:
	ADD	A,GRAN3
	JNB	OV,FINISH
	SETB	INTERNAL_RAM_ADDRESS_OVERFLOW_FLAG
FINISH:
	MOV	INTERNAL_RAM_ADDRESS_SUM_RESULT,A
	SJMP	$
;*******************************************************************************
	END
