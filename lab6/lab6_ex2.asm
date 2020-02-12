;=================================================
; Name: Christopher Young
; Email: cyoun069@ucr.edu
; 
; Lab: lab 6, ex 2
; Lab section: 025
; TA: Jang-Shin Lin
; 
;=================================================

;------------------------------------------------------------------------------------------------------------------
; Subroutine: SUB_IS_A_PALINDROME
; Parameter (R1): The starting address of a null-terminated string
; Parameter (R5): The number of characters in the array.
; Postcondition: The subroutine has determined whether the string at (R1) is
; a palindrome or not, and returned a flag to that effect.
; Return Value: R4 {1 if the string is a palindrome, 0 otherwise}
;------------------------------------------------------------------------------------------------------------------
.ORIG x3400
SUB_IS_A_PALINDROME

; Backup Registers

ST R0, BACK_UP_R0_3400
ST R1, BACK_UP_R1_3400
ST R2, BACK_UP_R2_3400
ST R3, BACK_UP_R3_3400
ST R5, BACK_UP_R5_3400
ST R7, BACK_UP_R7_3400

; Subroutine Instruction
ADD R2, R1, #0 ; Set R2 to address of first character
ADD R3, R1, R5 ; Set R3 to address of last character
ADD R3, R3, #-1

CHECK_LOOP
	; Check if lhs address - rhs address = 0
	ADD R4, R3, #0
	NOT R4, R4
	ADD R4, R4, R2 ; Subtract RHS Address from LHS Address
	BRz IS_PALINDROME
	ADD R4, R4, #1
	BRz IS_PALINDROME ; In case n was odd
	
	; Check if lhs value - rhs value = 0
	LDR R4, R2, #0 ; Load the value of R2 into R4
	LDR R5, R3, #0 ; Load the value of R3 into R5
	
	NOT R5, R5 ; Invert
	ADD R5, R5, #1 ; Add 1 (2's compliment for negative)
	ADD R0, R4, R5 ; Subtract RHS character from LHS character 
	
	ADD R2, R2, #1 ; Counters
	ADD R3, R3, #-1
	
	ADD R0, R0, #0 ; LMR
	BRz CHECK_LOOP
	BRnp NOT_PALINDROME
	
NOT_PALINDROME
	AND R4, R4, #0
	BRnzp END
	
IS_PALINDROME
	AND R4, R4, #0
	ADD R4, R4, #1
	
END

; Restore Registers 
LD R0, BACK_UP_R0_3400
LD R1, BACK_UP_R1_3400
LD R2, BACK_UP_R2_3400
LD R3, BACK_UP_R3_3400
LD R5, BACK_UP_R5_3400
LD R7, BACK_UP_R7_3400

; Return
RET

; Subroutine Data

BACK_UP_R0_3400 .BLKW #1
BACK_UP_R1_3400 .BLKW #1
BACK_UP_R2_3400 .BLKW #1
BACK_UP_R3_3400 .BLKW #1
BACK_UP_R5_3400 .BLKW #1
BACK_UP_R7_3400 .BLKW #1

.END
