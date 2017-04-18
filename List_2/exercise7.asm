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
;  Ex. : #7
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
	INTERNAL_RAM_ADDRESS_TABLE_START	EQU	020H
	INTERNAL_RAM_ADDRESS_TABLE_END		EQU	07FH
	INTERNAL_RAM_ADDRESS_SORTED_TABLE_START	EQU	080H
;*******************************************************************************

;*******************************************************************************
; @CODE
;  Main code
;------------------------------------------------------------------------------
	ORG	0
	MOV	R0,#INTERNAL_RAM_ADDRESS_TABLE_START
	MOV	R1,#INTERNAL_RAM_ADDRESS_TABLE_END
	MOV	SP,#(INTERNAL_RAM_ADDRESS_TABLE_END+1)
	LCALL	QUICK_SORT
	MOV	R0,#INTERNAL_RAM_ADDRESS_TABLE_START
	MOV	R1,#INTERNAL_RAM_ADDRESS_SORTED_TABLE_START
COPY:	MOV	A,@R0
	MOV	@R1,A
	INC	R0
	INC	R1
	CJNE	R0,#(INTERNAL_RAM_ADDRESS_TABLE_END + 1D),COPY
	SJMP	$
;*******************************************************************************

;*******************************************************************************
; @ROUTINE
;  QUICK_SORT
;------------------------------------------------------------------------------
; @Description
;  Runs a quicksort algorithm to sort in-place an array stored on internal ram
;  in ascending order, between the addresses pointed by R0 and R1, respectively.
;  Since the worst case scenario is unlikely to happen, the complexity of the
;  algorithm is assumed to be of its average case scenario: O(n log(n)). For
;  simplicity, takes the last element of the partition as pivot.
;------------------------------------------------------------------------------
; @Precondition
;  R0: Must be free to be used
;  R1: Must be free to be used
;  R5: Must be free to be used
;  R6: Must be free to be used
;  R7: Must be free to be used
;  SP: Must be moved to the internal ram address stored on R1 + 1
;------------------------------------------------------------------------------
; @Param
;  R0: Pointer for the first element of the sequence stored on internal ram
;  R1: Pointer for the last element of the sequence stored on internal ram
;------------------------------------------------------------------------------
; @Returns
;  Void
;------------------------------------------------------------------------------
; @See
;  https://en.wikipedia.org/wiki/Quicksort
;  https://www.youtube.com/watch?v=8hEyhs3OV1w
;  https://www.youtube.com/watch?v=ywWBy6J5gz8
;------------------------------------------------------------------------------
QUICK_SORT:
	MOV	A,R1
	CLR	C
	SUBB	A,R0
	JC	NEXT
	CJNE	A,#00H,RECURSION
NEXT:	RET
RECURSION:
	SJMP	PARTITION
RETURN:	MOV	A,R1
	PUSH	ACC
	MOV	A,R6
	PUSH	ACC
	DEC	A
	MOV	R1,A
	LCALL	QUICK_SORT
	POP	ACC
	MOV	R6,A
	INC	A
	MOV	R0,A
	POP	ACC
	MOV	R1,A
	LCALL	QUICK_SORT
	RET
PARTITION:
	MOV	A,R0
	PUSH	ACC
	MOV	A,R1
	PUSH	ACC
	MOV	A,@R1
	MOV	R7,A
	MOV	A,R1
	MOV	R6,A
	DEC	R1
PARTITION_LOOP:
	MOV	A,R7
	CLR	C
	SUBB	A,@R0
	JC	LO_HIGHER_THAN_PIVOT
	INC	R0
	SJMP	CHECK_INDEX
LO_HIGHER_THAN_PIVOT:
	MOV	A,R7
	CLR	C
	SUBB	A,@R1
	JNC	HI_LOWER_THAN_PIVOT
	DEC	R1
	SJMP	CHECK_INDEX
HI_LOWER_THAN_PIVOT:
	MOV	A,@R0
	XCH	A,@R1
	MOV	@R0,A
	INC	R0
	DEC	R1
CHECK_INDEX:
	MOV	A,R1
	CLR	C
	SUBB	A,R0
	JC	NEW_PIVOT_FOUND
	SJMP	PARTITION_LOOP
NEW_PIVOT_FOUND:
	MOV	A,R0
	MOV	R5,A
	MOV	A,R7
	XCH	A,@R0
	MOV	R7,A
	MOV	A,R6
	MOV	R0,A
	MOV	A,R7
	MOV	@R0,A
	MOV	A,R5
	MOV	R6,A
	POP	ACC
	MOV	R1,A
	POP	ACC
	MOV	R0,A
	SJMP	RETURN
;*******************************************************************************
	END
