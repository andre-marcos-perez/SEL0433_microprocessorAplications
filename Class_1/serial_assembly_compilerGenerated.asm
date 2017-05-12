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
; @Class
;  Class: # 1
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
L102:	SJMP	L102
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
	PUSH	ACC
	PUSH	DPL
	PUSH	DPH
	PUSH	06H
	PUSH	07H
	PUSH	PSW
	MOV	PSW,#00H
	JBC	RI,L133
	SJMP	L108
L133:	MOV	A,#'P'
	CJNE	A,SBUF,L113
	MOV	R7,#00H
L111:	MOV	A,R7
	MOV	DPTR,#STR
	MOVC	A,@A+DPTR
	MOV	R6,A
	CJNE	R6,#'$',L136
	SJMP	L113
L136:	MOV	SBUF,R6
L101:	JBC	TI,L137
	SJMP	L101
L137:	INC	R7
	SJMP	L111
L108:	CLR	TI
L113:	POP	PSW
	POP	06H
	POP	07H
	POP	DPH
	POP	DPL
	POP	ACC
RETURN:	RET
;*******************************************************************************
	END
