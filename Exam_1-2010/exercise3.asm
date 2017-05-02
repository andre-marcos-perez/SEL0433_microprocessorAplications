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
;  Exam: #1
;  Ex. : #3
;------------------------------------------------------------------------------
; @AUTHOR
;  Name:  Andre Marcos Perez
;  Email: andre.marcos.perez@usp.br
;  #USP:  8006891
;*******************************************************************************

;*******************************************************************************
; @CODE
;  Main code
;------------------------------------------------------------------------------
	ORG	0
INIT:	MOV	DPTR,#100H
	MOV	R1,#10D
VOLTA:	MOV	A,R1
	MOV	R0,#10D
LOOP:	CPL	P2.1
	DJNZ	R0,LOOP
	MOVX	@DPTR,A
	INC	DPTR
	INC	R1
	CJNE	R1,#20D,VOLTA
	SJMP	$
;*******************************************************************************

;*******************************************************************************
; @QUESTIONS
;------------------------------------------------------------------------------
;  A: Label 'INIT' at 0x0000 and 'VOLTA' at 0x0005 of internal rom.
;------------------------------------------------------------------------------
;  B: 0x12 or 18 decimal.
;------------------------------------------------------------------------------
;  C: 0x14 or 20 decimal.
;------------------------------------------------------------------------------
;  D: The Led will blink 100 times, thus turning on 50 times.
;*******************************************************************************
	END
