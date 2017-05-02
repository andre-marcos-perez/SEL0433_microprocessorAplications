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
	CONSTANT_TIMER_0VERFLOW_50MS	EQU	(50000 * 11.0592 / 12)
;*******************************************************************************

;*******************************************************************************
; @WARNING
;  Code's warnings
;------------------------------------------------------------------------------
;  The warning: 'UART mode has been changed while UART was engaged' must be ignored
;*******************************************************************************

;*******************************************************************************
; @CODE
;  Main code
;------------------------------------------------------------------------------
	ORG	0000H
	SJMP	MAIN
	ORG	0003H
	LCALL	ISR_INT0
	RETI
	ORG	000BH
	LCALL	ISR_TIMER0
	RETI
	ORG	0013H
	LCALL	ISR_INT1
	RETI
	ORG	0023H
	LCALL	ISR_SERIAL
	RETI
MAIN:	SETB	EX0
	SETB	PX0
	MOV	TMOD,#21H
	MOV	TH0,#(0FFH - HIGH CONSTANT_TIMER_0VERFLOW_50MS)
	MOV	TL0,#(0FFH - LOW  CONSTANT_TIMER_0VERFLOW_50MS)
	SETB	TR0
	SETB	ET0
	SETB	PT0
	SETB	EX1
	MOV	TH1,#0FDH
	MOV	TL1,#0FDH
	MOV	SCON,#50H
	SETB	TR1
	SETB	ES
	SETB	EA
	MOV	R7,#100D
LOOP:	CJNE	R7,#00H,$
	MOV	R7,#100D
	SETB	RI
	SJMP	LOOP
;*******************************************************************************

;*******************************************************************************
; @INTERRUPTION
;  ISR_INT0
;------------------------------------------------------------------------------
; @Description
;  Interruption service routine for external interruption 0.
;------------------------------------------------------------------------------
; @Param
;  Void
;------------------------------------------------------------------------------
; @Returns
;  Void
;------------------------------------------------------------------------------
ISR_INT0:
	MOV	DPTR,#5000H
	MOVX	A,@DPTR
	MOV	P1,A
	RET
;*******************************************************************************

;*******************************************************************************
; @INTERRUPTION
;  ISR_TIMER0
;------------------------------------------------------------------------------
; @Description
;  Interruption service routine for timer 0 interruption.
;------------------------------------------------------------------------------
; @Precondition
;  R7: Must be free to be used.
;  CONSTANT_TIMER_0VERFLOW_50MS: The number of times the timer 0 on mode 1 must
;				 count to generate a overflow of 50 ms must be
;				 defined on this constant
;------------------------------------------------------------------------------
; @Param
;  Void
;------------------------------------------------------------------------------
; @Returns
;  Void
;------------------------------------------------------------------------------
ISR_TIMER0:
	MOV	TH0,#(0FFH - HIGH CONSTANT_TIMER_0VERFLOW_50MS)
	MOV	TL0,#(0FFH - LOW  CONSTANT_TIMER_0VERFLOW_50MS)
	MOV	A,7FH
	MOV	DPTR,#5200H
	MOVX	@DPTR,A
	DEC	R7
	RET
;*******************************************************************************

;*******************************************************************************
; @INTERRUPTION
;  ISR_INT1
;------------------------------------------------------------------------------
; @Description
;  Interruption service routine for external interruption 1.
;------------------------------------------------------------------------------
; @Param
;  Void
;------------------------------------------------------------------------------
; @Returns
;  Void
;------------------------------------------------------------------------------
ISR_INT1:
	MOV	DPTR,#5000H
	MOVX	A,@DPTR
	MOV	7FH,A
	RET
;*******************************************************************************

;*******************************************************************************
; @INTERRUPTION
;  ISR_SERIAL
;------------------------------------------------------------------------------
; @Description
;  Interruption service routine for serial interruption.
;------------------------------------------------------------------------------
; @Param
;  Void
;------------------------------------------------------------------------------
; @Returns
;  Void
;------------------------------------------------------------------------------
ISR_SERIAL:
	CLR	RI
	MOV	DPTR,#5200H
	MOVX	A,@DPTR
	MOV	SBUF,A
	JNB	TI,$
	CLR	TI
	RET
;*******************************************************************************
	END
