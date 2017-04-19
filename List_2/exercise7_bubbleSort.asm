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
	LCALL	BUBBLE_SORT
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
;  BUBBLE_SORT
;------------------------------------------------------------------------------
; @Description
;  Runs a bubblesort algorithm to sort in-place an array stored on internal ram
;  in ascending order. Its average and worst case scenario complexity is O(n^2).
;------------------------------------------------------------------------------
; @Precondition
;  F0: Must be free to be used
;  R0: Must be free to be used
;  R1: Must be free to be used
;  INTERNAL_RAM_ADDRESS_TABLE_START: The first element address of the array 
; 				     stored on internal ram must be defined on
;				     this constant
;  INTERNAL_RAM_ADDRESS_TABLE_END:   The last element address of the array 
; 				     stored on internal ram must be defined on
;				     this constant
;------------------------------------------------------------------------------
; @Param
;  Void
;------------------------------------------------------------------------------
; @Returns
;  Void
;------------------------------------------------------------------------------
; @See
;  https://en.wikipedia.org/wiki/Bubble_sort
;  https://www.youtube.com/watch?v=Cq7SMsQBEUw
;  https://www.youtube.com/watch?v=lyZQPjUT5B4
;------------------------------------------------------------------------------
BUBBLE_SORT:
	CLR	F0
	MOV	R0,#(INTERNAL_RAM_ADDRESS_TABLE_START+0)
	MOV	R1,#(INTERNAL_RAM_ADDRESS_TABLE_START+1)
ARRAY_END_NOT_REACHED:
	CLR	C
	MOV	A,@R0
	SUBB	A,@R1
	JC	R0_IS_LOWER
	MOV	A,@R0
	XRL	A,@R1
	CJNE	A,#00H,SWAP_R0_R1
	SJMP	R0_IS_LOWER
SWAP_R0_R1:
	MOV	A,@R0
	XCH	A,@R1
	MOV	@R0,A
	SETB	F0
R0_IS_LOWER:
	INC	R0
	INC	R1
	CJNE	R0,#INTERNAL_RAM_ADDRESS_TABLE_END,ARRAY_END_NOT_REACHED
	JB	F0,BUBBLE_SORT
	RET
;*******************************************************************************
	END
