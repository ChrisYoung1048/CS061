;=================================================
; Name: Christopher Young
; Email: cyoun069@ucr.edu
; 
; Lab: lab 8, ex 1 & 2
; Lab section: 025
; TA: Jang-Shin Lin
; 
;=================================================

; Testing Harness
.ORIG x3000

LD R1, SUB_PRINT_OPCODES
JSRR R1	

LD R2, STRING_ADDRESS

LD R1, SUB_FIND_OPCODE
JSRR R1				 

				 
HALT
;-----------------------------------------------------------------------------------------------
; Local Data
STRING_ADDRESS .FILL x4200

SUB_PRINT_OPCODES .FILL x3200
SUB_FIND_OPCODE .FILL x3600
;===============================================================================================


; Subroutines
;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODES
; Parameters: None
; Postcondition: The subroutine has printed out a list of every LC3 instruction
;		 		 and corresponding opcode in the following format:
;		 		 ADD = 0001
;		  		 AND = 0101
;		  		 BR = 0000
;		  		 …
; Return Value: None
;-----------------------------------------------------------------------------------------------
.ORIG x3200

; Backup Registers
ST R0, BACK_UP_R0_3200
ST R1, BACK_UP_R1_3200
ST R2, BACK_UP_R2_3200
ST R3, BACK_UP_R3_3200
ST R7, BACK_UP_R7_3200

; Subroutine Instruction
LD R1, instructions_po_ptr
LD R4, opcodes_po_ptr
;ADD R2, R2, #1

PRINT_LOOP

PRINT_STRING_FORM
	LDR R0, R1, #0 ; Print the opcode in string form
	OUT
	ADD R1, R1, #1
	ADD R0, R0, #0 ; LMR
	BRnp PRINT_STRING_FORM ; Stop printing the opcode when a 0 is detected. 0 denotes a space in the string array
	
	LEA R0, MSG_EQUALS ; Print ' = '
	PUTS
	
	LDR R2, R4, #0
	LD R3, SUB_PRINT_OPCODE
	JSRR R3 ; Run subroutine that prints out binary into characters
	
	LEA R0, MSG_NEWLINE
	PUTS
	
	ADD R4, R4, #1 ; Increment Counters
	
	LDR R3, R1, #0 ; Store the value of the address in R2 into R3
	
	BRn END_PRINT_LOOP ; If the value in the strings array is -1, end
	BR PRINT_LOOP ; Else, continue the print loop
	
END_PRINT_LOOP

; Load Registers
LD R0, BACK_UP_R0_3200
LD R1, BACK_UP_R1_3200
LD R2, BACK_UP_R2_3200
LD R3, BACK_UP_R3_3200
LD R7, BACK_UP_R7_3200

; Return
RET				 
				 
; Subroutine Data				 
BACK_UP_R0_3200 .BLKW #1
BACK_UP_R1_3200 .BLKW #1
BACK_UP_R2_3200 .BLKW #1
BACK_UP_R3_3200 .BLKW #1
BACK_UP_R7_3200 .BLKW #1

;-----------------------------------------------------------------------------------------------
; SUB_PRINT_OPCODES local data
opcodes_po_ptr		.fill x4000
instructions_po_ptr	.fill x4100

MSG_EQUALS .STRINGZ " = "
MSG_NEWLINE .STRINGZ "\n"

SUB_PRINT_OPCODE .fill x3400

;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODE
; Parameters: R2 containing a 4-bit op-code in the 4 LSBs of the register
; Postcondition: The subroutine has printed out just the 4 bits as 4 ascii 1s and 0s
;				 The output is NOT newline terminated.
; Return Value: None
;-----------------------------------------------------------------------------------------------
.ORIG x3400
				 
; Backup Registers
ST R0, BACK_UP_R0_3400
ST R1, BACK_UP_R1_3400
ST R2, BACK_UP_R2_3400
ST R3, BACK_UP_R3_3400
ST R7, BACK_UP_R7_3400

; Subroutine Instruction
AND R1, R1, #0 ; Clear R1
ADD R1, R1, #4 ; Set R1 as Counter
LD R3, PO_TO_ASCII ; Set R3 to #48

;I'm lazy so I'm going to remove the first 12 bits by doing this
ADD R2, R2, R2
ADD R2, R2, R2
ADD R2, R2, R2
ADD R2, R2, R2

ADD R2, R2, R2
ADD R2, R2, R2
ADD R2, R2, R2
ADD R2, R2, R2

ADD R2, R2, R2
ADD R2, R2, R2
ADD R2, R2, R2
ADD R2, R2, R2

CHECK_MSB
	ADD R2, R2, #0 ; Set R2 to LMR
	BRn PRINT_ONE
	BR PRINT_ZERO
	
PRINT_ONE
	AND R0, R0, #0
	ADD R0, R0, #1
	ADD R0, R0, R3 ; Set R0 to the character '1'
	OUT
	BR CHECK_COUNTER
	
PRINT_ZERO
	AND R0, R0, #0
	ADD R0, R0, R3 ; Set R0 to the character '0'
	OUT

CHECK_COUNTER
	ADD R2, R2, R2
	ADD R1, R1, #-1
	BRp CHECK_MSB

; Load Registers
LD R0, BACK_UP_R0_3400
LD R1, BACK_UP_R1_3400
LD R2, BACK_UP_R2_3400
LD R3, BACK_UP_R3_3400
LD R7, BACK_UP_R7_3400

; Return
RET				 
				 
; Subroutine Data				 
BACK_UP_R0_3400 .BLKW #1
BACK_UP_R1_3400 .BLKW #1
BACK_UP_R2_3400 .BLKW #1
BACK_UP_R3_3400 .BLKW #1
BACK_UP_R7_3400 .BLKW #1			 

;-----------------------------------------------------------------------------------------------
; SUB_PRINT_OPCODE local data
PO_TO_ASCII .FILL #48 

;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_FIND_OPCODE
; Parameters: None
; Postcondition: The subroutine has invoked the SUB_GET_STRING subroutine and stored a string
; 				as local data; it has searched the AL instruction list for that string, and reported
;				either the instruction/opcode pair, OR "Invalid instruction"
; Return Value: None
;-----------------------------------------------------------------------------------------------
.ORIG x3600

; Backup Registers
ST R0, BACK_UP_R0_3600
ST R1, BACK_UP_R1_3600
ST R2, BACK_UP_R2_3600
ST R3, BACK_UP_R3_3600
ST R4, BACK_UP_R4_3600
ST R5, BACK_UP_R5_3600
ST R6, BACK_UP_R6_3600
ST R7, BACK_UP_R7_3600

; Subroutine Instructions
LD R1, SUB_GET_STRING
JSRR R1 ; Get string from user and store into R2

LD R1, instructions_fo_ptr ; Set R1 as pointer to the Instruction Array
; R2 is the address to the user inputted string
AND R3, R3, #0 ; Set R3 as the position in a string
LD R7, opcodes_fo_ptr ; Set R7 as pointer to opcodes

AND R4, R4, #0 
ADD R4, R4, R1 ; Use R4 to traverse through Instruction Array
; NEVERMIND THIS R2 will be incremeted to traverse through user inputted string

FIND_OPCODE_LOOP
	ADD R0, R3, #0 ; Check for position of character to be checked
	BRz POSITION_0
	ADD R0, R3, #-1
	BRz POSITION_1
	ADD R0, R3, #-2
	BRz POSITION_2
	ADD R0, R3, #-3
	BRz POSITION_3
	ADD R0, R3, #-4
	BRz POSITION_4
	
POSITION_0
	LDR R5, R2, #0  ; Load user inputted character into R5
	LDR R6, R4, #0 ; Load instruction character into R6
	BRn ERROR_MESSAGE ; If R6 holds the value -1, exit with error message
	BR COMPARE_CHARACTERS
	
POSITION_1
	LDR R5, R2, #1
	LDR R6, R4, #1
	BRn ERROR_MESSAGE
	BR COMPARE_CHARACTERS

POSITION_2
	LDR R5, R2, #2
	LDR R6, R4, #2
	BRn ERROR_MESSAGE
	BR COMPARE_CHARACTERS
	
POSITION_3
	LDR R5, R2, #3
	LDR R6, R4, #3
	BRn ERROR_MESSAGE
	BR COMPARE_CHARACTERS
	
POSITION_4 
	LDR R5, R2, #4
	LDR R6, R4, #4
	BRn ERROR_MESSAGE
	BR COMPARE_CHARACTERS
	
COMPARE_CHARACTERS
	NOT R0, R6 ; Set R0 to negative R6
	ADD R0, R0, #1
	ADD R0, R5, R0 ; Subtract R6 from R5 and store into R0
	BRz NEXT_CHARACTER ; If both characters are equal, move to check next character
	BR FIND_NEXT_INSTRUCTION ; Else, compare the next instruction
	
NEXT_CHARACTER ;WRITE A SUBROUTINE TO ACCOUNT FOR SCRAMBLING (COMPARE SUM OF CHARACTERS IN DECIMAL)
	; ===
	ADD R6, R6, #0 ; Set R6 to LMR
	BRz PRINT_USER_INPUT ; If the character is 0, then the instruction check is complete
	
	; OR (The succes condition below needs to be refined)
	
	; AND R0, R0, #0 ; Clear R0 to use a sum
	; AND R5, R5, #0 ; Clear R5 to use as traversal
	; ADD R5, R5, R2 ; Use R5 to traverse user input
	; BR ADD_SUM_USER_INPUT ; Store sum of ascii values in user input into R0
	; FINISH_ADD_SUM
	
	; LD R5, SUM_ASCII_JSRR
	; ADD R0, R0, R5 ; Compare the sum of user's ascii to the ascii sum of JSRR (#321)
	; BRz PRINT_USER_INPUT ; If the sums match, then the user instruction is valid, so print it
	; ===
	
	ADD R3, R3, #1 ; Increment the position in the string by 1
	; AND R4, R4, #0 
	; ADD R4, R4, R1 ; Reset R4 to point back to the beginning of the array
	BR FIND_OPCODE_LOOP
	
FIND_NEXT_INSTRUCTION
	AND R3, R3, #0 ; Set position back to 0
	LDR R0, R4, #0 ; Load the character at from the current address into R0
	BRz NEXT_INSTRUCTION_FOUND ; If the value is zero, next instruction is found
	BR NEXT_INSTRUCTION_NOT_FOUND

NEXT_INSTRUCTION_FOUND
	ADD R7, R7, #1 ; Go to next opcode
	ADD R4, R4, #1 ; Since R4 is currently 0, it needs to be incremented to become the first character of the next function
	BR FIND_OPCODE_LOOP

NEXT_INSTRUCTION_NOT_FOUND
	LDR R0, R4, #0 ; Load the character at from the current address into R0
	BRn ERROR_MESSAGE ; If the value is -1, then no instructions match
	ADD R4, R4, #1 ; Increment by 1 until the zero is reached
	BR FIND_NEXT_INSTRUCTION
	
ERROR_MESSAGE
	LEA R0, MSG_ERROR
	PUTS
	BR END_SUB_FO
	
;ADD_SUM_USER_INPUT ; Compare sum to check for JSRR exception
;	LDR R6, R5, #0 ; Load value into R6
;	BRz FINISH_ADD_SUM ; Zero denoting the end of the string
;	ADD R0, R0, R6
;	ADD R5, R5, #1
;	BR ADD_SUM_USER_INPUT
	
PRINT_USER_INPUT
	AND R6, R6, #0
	ADD R6, R6, R7  ; R7 cause problems so I'm moving its value to R6

PRINT_USER_INPUT_Pt2
	LDR R0, R2, #0
	BRz PRINT_REMAINING ; Zero denoting the end of the string
	OUT ; Out does something to change R7
	ADD R2, R2, #1
	BR PRINT_USER_INPUT_Pt2

PRINT_REMAINING
	LEA R0, MSG_FO_EQUALS
	PUTS
	
	LDR R2, R6, #0
	LD R1, SUB_FO_PRINT_OPCODE ; Print rest of message
	JSRR R1
	
	LEA R0, MSG_FO_NEWLINE
	PUTS

END_SUB_FO

; Restore Registers 
LD R0, BACK_UP_R0_3600
LD R1, BACK_UP_R1_3600
LD R2, BACK_UP_R2_3600
LD R3, BACK_UP_R3_3600
LD R4, BACK_UP_R4_3600
LD R5, BACK_UP_R5_3600
LD R6, BACK_UP_R6_3600
LD R7, BACK_UP_R7_3600

; Return			 
RET
;-----------------------------------------------------------------------------------------------
; SUB_FIND_OPCODE local data
opcodes_fo_ptr			.fill x4000
instructions_fo_ptr		.fill x4100

MSG_FO_EQUALS .STRINGZ " = "
MSG_FO_NEWLINE .STRINGZ "\n"
MSG_ERROR .STRINGZ "Invalid Instruction"
; SUM_ASCII_JSRR .FILL #-321

SUB_GET_STRING .FILL x3800
SUB_FO_PRINT_OPCODE .FILL x3400

BACK_UP_R0_3600 .BLKW #1
BACK_UP_R1_3600 .BLKW #1
BACK_UP_R2_3600 .BLKW #1
BACK_UP_R3_3600 .BLKW #1
BACK_UP_R4_3600 .BLKW #1
BACK_UP_R5_3600 .BLKW #1
BACK_UP_R6_3600 .BLKW #1
BACK_UP_R7_3600 .BLKW #1

;===============================================================================================

;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameters: R2 - the address to which the null-terminated string will be stored.
; Postcondition: The subroutine has prompted the user to enter a short string, terminated 
; 				by [ENTER]. That string has been stored as a null-terminated character array 
; 				at the address in R2
; Return Value: None (the address in R2 does not need to be preserved)
;-----------------------------------------------------------------------------------------------
.ORIG x3800
				 
; Backup Registers
ST R0, BACK_UP_R0_3800
ST R1, BACK_UP_R1_3800
; R2 does not need to be preserved
ST R2, BACK_UP_R2_3800
ST R7, BACK_UP_R7_3800

; Subroutine Instruction
GET_STRING_LOOP
	GETC ; Get user input
	OUT
	
	LD R1, CHECK_CHAR_NEWLINE ; Check if input is newlines
	ADD R1, R1, R0
	BRz END_GET_STRING_LOOP
	
	STR R0, R2, #0 ; Store character into address at R2
	ADD R2, R2, #1 ; Increment the address in R2 to the next address
	BR GET_STRING_LOOP
	
END_GET_STRING_LOOP

; Restore Registers 
LD R0, BACK_UP_R0_3800
LD R1, BACK_UP_R1_3800
LD R2, BACK_UP_R2_3800
LD R7, BACK_UP_R7_3800

; Return	 		 	 
RET

;-----------------------------------------------------------------------------------------------
; SUB_GET_STRING local data
CHECK_CHAR_NEWLINE .FILL #-10

BACK_UP_R0_3800 .BLKW #1
BACK_UP_R1_3800 .BLKW #1
BACK_UP_R2_3800 .BLKW #1
BACK_UP_R7_3800 .BLKW #1

;===============================================================================================


;-----------------------------------------------------------------------------------------------
; REMOTE DATA
.ORIG x4000			; list opcodes as numbers, e.g. .fill #12 or .fill xC
opcodes

.FILL #0
.FILL #1
.FILL #2
.FILL #3
.FILL #4
.FILL #4
.FILL #5
.FILL #6
.FILL #7
.FILL #8
.FILL #9
.FILL #10
.FILL #11
.FILL #12
.FILL #12
.FILL #13
.FILL #14
.FILL #15
.FILL #16


.ORIG x4100			; list AL instructions as null-terminated character strings, e.g. .stringz "JMP"
instructions				 			; - be sure to follow same order in opcode & instruction arrays!

.STRINGZ "BR" 
.STRINGZ "ADD" 
.STRINGZ "LD" 
.STRINGZ "ST" 
.STRINGZ "JSR"
.STRINGZ "JSRR"
.STRINGZ "AND" 
.STRINGZ "LDR" 
.STRINGZ "STR" 
.STRINGZ "RTI" 
.STRINGZ "NOT" 
.STRINGZ "LDI" 
.STRINGZ "STI" 
.STRINGZ "JMP" 
.STRINGZ "RET" 
.STRINGZ "reserved" 
.STRINGZ "LEA" 
.STRINGZ "TRAP" 
.FILL #-1

;===============================================================================================

.END
