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
;  Ex. : # 3
;  Part: # B
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
	STRING_TX_CONTROL_CHAR	EQU	'P'
;*******************************************************************************

;*******************************************************************************
; @CODE
;  Main code
;------------------------------------------------------------------------------
	ORG	0
	SJMP	MAIN
	ORG	23H
	ACALL	ISR_SERIAL
	RETI
MAIN:	MOV	TMOD,#20H
	MOV	TH1,#0FDH
	MOV	TL1,#0FDH
	MOV	SCON,#50H
	SETB	TR1
	SETB	ES
	SETB	EA
	SJMP	$
STR:	DB	'UNIVERSITY OF SAO PAULO AT ENGINEERING SCHOOL OF SAO CARLOS','$'
;*******************************************************************************

;*******************************************************************************
; @INTERRUPTION
;  ISR_SERIAL
;------------------------------------------------------------------------------
; @Description
;  Interruption service routine to check if a character received from uart is
;  the ASCII code for the letter P. If true, sends through uart a message stored
;  in the internal rom, otherwise, returns.
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
	CJNE	A,#STRING_TX_CONTROL_CHAR,RETURN
	MOV	DPTR,#STR
TX_STR:	CLR	A
	MOVC	A,@A+DPTR
	CJNE	A,#STRING_TERMINATOR,TX_CHAR
	SJMP	RETURN
TX_CHAR:MOV	SBUF,A
	JNB	TI,$
	CLR	TI
	INC	DPTR
	SJMP	TX_STR
RETURN:	RET
;*******************************************************************************
	END
