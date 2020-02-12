;=================================================
; Name: Christopher Young
; Email: cyoun069@ucr.edu
; 
; Lab: lab 6, ex 3
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
LD R0, SUB_TO_UPPER
JSRR R0

ADD R2, R1, #0 ; Set R2 to address of first character
ADD R3, R1, R5 ; Set R3 to address of last character
ADD R3, R3, #-1 ; Account for NULL Address

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
	
	; Check for space character
	LD R0, ascii_space
	ADD R0, R0, R4
	BRz SHIFT_LHS
	
	LD R0, ascii_space
	ADD R0, R0, R5
	BRz SHIFT_RHS
	
	BR CONTINUE_LOOP
	
SHIFT_LHS
	ADD R2, R2, #1
	BR CHECK_LOOP
	
SHIFT_RHS 
	ADD R3, R3, #-1
	BR CHECK_LOOP
	
CONTINUE_LOOP
	; Compare lhs and rhs characters
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
	BRnzp PRINT_MSG
	
IS_PALINDROME
	AND R4, R4, #0
	ADD R4, R4, #1
	
PRINT_MSG
	LEA R0, MSG_INTRO
	PUTS
	
	AND R0, R0, #0 ; Set R0 to 0
	ADD R0, R0, R1 ; Set R0 to starting address of null-terminated string
	PUTS ; PUTS detects the 0 at the end of a string as the sentinal value
		
	ADD R4, R4, #0 ; LMR
	BRp PRINT_IS_PALINDROME
	
PRINT_IS_NOT_PALINDROME
	LEA R0, MSG_IS_NOT_PALINDROME
	PUTS
	BR END_SUBROUTINE

PRINT_IS_PALINDROME
	LEA R0, MSG_IS_PALINDROME
	PUTS
	BR END_SUBROUTINE
	
END_SUBROUTINE	

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
ascii_space .FILL #0 ; WHY a 0? and not ascii for space x20

MSG_INTRO .STRINGZ "The string "
MSG_IS_PALINDROME .STRINGZ " is a palindrome"
MSG_IS_NOT_PALINDROME .STRINGZ " is NOT a palindrome"

SUB_TO_UPPER .FILL x3600

BACK_UP_R0_3400 .BLKW #1
BACK_UP_R1_3400 .BLKW #1
BACK_UP_R2_3400 .BLKW #1
BACK_UP_R3_3400 .BLKW #1
BACK_UP_R5_3400 .BLKW #1
BACK_UP_R7_3400 .BLKW #1

;------------------------------------------------------------------------------------------------------------------
; Subroutine: SUB_TO_UPPER
; Parameter (R1): Starting address of a null-terminated string
; Postcondition: The subroutine has converted the string to upper-case in-place
; i.e. the upper-case string has replaced the original string
; No return value, no output (but R1 still contains the array address, unchanged).
;------------------------------------------------------------------------------------------------------------------
.ORIG x3600
;SUB_TO_UPPER

; Backup Registers
ST R1, BACK_UP_R1_3600
ST R2, BACK_UP_R2_3600
ST R3, BACK_UP_R3_3600
ST R7, BACK_UP_R7_3600

; Subroutine Instruction
LD R2, HEX_20
NOT R2, R2 ; Use this to convert to Uppercase

UPPER_CONVERT_LOOP
	LDR R3, R1, #0
	BRz END_UPPER_LOOP; If the value is null-terminate / 0 
	AND R3, R3, R2
	STR R3, R1, #0 ; Store upper-case value back into array
	ADD R1, R1, #1 ; Traverse the array
	BR UPPER_CONVERT_LOOP

END_UPPER_LOOP

; Restore Registers
LD R1, BACK_UP_R1_3600
LD R2, BACK_UP_R2_3600
LD R3, BACK_UP_R3_3600
LD R7, BACK_UP_R7_3600

; Return
RET

; Subroutine Data
HEX_20 .FILL x20

BACK_UP_R1_3600 .BLKW #1
BACK_UP_R2_3600 .BLKW #1
BACK_UP_R3_3600 .BLKW #1
BACK_UP_R7_3600 .BLKW #1


.END
