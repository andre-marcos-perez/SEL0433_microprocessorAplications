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
;  Ex. : #3
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
	COR1	EQU	02H
	COR2	EQU	10H
	COR3	EQU	80H
	RES	EQU	20H
	INTERNAL_RAM_ADDRESS_OVERFLOW_FLAG	EQU	22H.0
;*******************************************************************************

;*******************************************************************************
; @CODE
;  Main code
;------------------------------------------------------------------------------
	ORG	0
	MOV	(COR1+0),#023H
	MOV	(COR1+1),#0F5H
	MOV	(COR2+0),#06EH
	MOV	(COR2+1),#0AAH
	MOV	R0,#(COR3+0)
	MOV	@R0,#0C7H
	MOV	R0,#(COR3+1)
	MOV	@R0,#059H
	MOV	R0,#(COR1+1)
	ADD	A,@R0
	MOV	R1,#(COR2+1)
	ADD	A,@R1
	LCALL	CHECK_OVERFLOW_FLAG
	XCH	A,R7
	MOV	R0,#(COR1+0)
	MOV	R1,#(COR2+0)
	ADDC	A,@R0
	ADD	A,@R1
	LCALL	CHECK_OVERFLOW_FLAG
	XCH	A,R7
	MOV	R0,#(COR3+1)
	ADD	A,@R0
	LCALL	CHECK_OVERFLOW_FLAG
	MOV	(RES+1),A
	XCH	A,R7
	MOV	R0,#(COR3+0)
	ADDC	A,@R0
	LCALL	CHECK_OVERFLOW_FLAG
	MOV	(RES+0),A
	SJMP	$
;*******************************************************************************

;*******************************************************************************
; @ROUTINE
;  CHECK_OVERFLOW_FLAG
;------------------------------------------------------------------------------
; @Description
;  Check whether the overflow was set on the last arithmetic operation and save it
;  on the INTERNAL_RAM_ADDRESS_OVERFLOW_FLAG address.
;------------------------------------------------------------------------------
; @Param
;  void
;------------------------------------------------------------------------------
; @Returns
;  OV:	The overflow flag status on INTERNAL_RAM_ADDRESS_OVERFLOW_FLAG address
;------------------------------------------------------------------------------
CHECK_OVERFLOW_FLAG:
	JNB	OV,RETURN
	SETB	INTERNAL_RAM_ADDRESS_OVERFLOW_FLAG
RETURN:	RET
;*******************************************************************************
	END
