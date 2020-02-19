;=================================================
; Name: Christopher Young
; Email: cyoun069@ucr.edu
; 
; Lab: lab 7, ex 2
; Lab section: 025
; TA: Jang-Shin Lin
; 
;=================================================

.ORIG x3000
; Instruction
LEA R0, MSG_PROMPT 
PUTS ; Print prompt
GETC ; Get user input
OUT

AND R1, R1, #0 ; Clear R1
ADD R1, R1, R0 ; Copy R0 into R1

LD R0, CHARACTER_NEWLINE ; Newline
OUT 

LD R2, SUB_BINARY_COUNT_1
JSRR R2

; AND R1, R1, #0 ; Clear R1
; ADD R1, R1, R0 ; Set R1 to R0 (User's Input)

LEA R0, MSG_OUTPUT_PART1 ; Print Output
PUTS

AND R0, R0, #0
ADD R0, R0, R1 ; Set R0 back to R1 (User's Input)
OUT

LEA R0, MSG_OUTPUT_PART2
PUTS

LD R1, TO_ASCII
ADD R0, R6, R1 ; Convert R6 to ascii
OUT
	

HALT

; Local Data
MSG_PROMPT .STRINGZ "Input a single character:\n"
MSG_OUTPUT_PART1 .STRINGZ "The number of 1's in '"
MSG_OUTPUT_PART2 .STRINGZ "' is: "

TO_ASCII .FILL #48

CHARACTER_NEWLINE .FILL x0A
SUB_BINARY_COUNT_1 .FILL x3200

;------------------------------------------------------------------------------------------------------------------
; Subroutine: SUB_BINARY_COUNT_1
; Parameter (R1): Character that the user inputs
; Postcondition: Subroutine determines count of 1s in the binary form of a character
; Return Value (R6) : Count of 1s that appear in the binary form of a character
;------------------------------------------------------------------------------------------------------------------
.ORIG x3200

; Backup Registers
ST R0, BACK_UP_R0_3200
ST R1, BACK_UP_R1_3200
ST R2, BACK_UP_R2_3200
ST R3, BACK_UP_R3_3200
ST R4, BACK_UP_R4_3200
ST R5, BACK_UP_R5_3200
; ST R6, BACK_UP_R6_3200
ST R7, BACK_UP_R7_3200

; Subroutine Instruction
LD R3, LOOP_COUNTER ; Set R3 as counter with value 16
AND R6, R6, #0 ; Clear R6

LOOP
	ADD R1, R1, #0 ; Set R1 to LMR
	BRn MSB_NEGATIVE ; Check if most significant bit is negative
	BR MSB_POSTIVE
	
MSB_NEGATIVE
	ADD R6, R6, #1 ; Increment count of 1s

MSB_POSTIVE
	ADD R1, R1, R1
	ADD R3, R3, #-1
	BRz END_LOOP
	BR LOOP
	
END_LOOP

; Restore Registers
LD R0, BACK_UP_R0_3200
LD R1, BACK_UP_R1_3200
LD R2, BACK_UP_R2_3200
LD R3, BACK_UP_R3_3200
LD R4, BACK_UP_R4_3200
LD R5, BACK_UP_R5_3200
; LD R6, BACK_UP_R6_3200
LD R7, BACK_UP_R7_3200

; Return 
RET

; Subroutine Data
LOOP_COUNTER .FILL #16

BACK_UP_R0_3200 .BLKW #1
BACK_UP_R1_3200 .BLKW #1
BACK_UP_R2_3200 .BLKW #1
BACK_UP_R3_3200 .BLKW #1
BACK_UP_R4_3200 .BLKW #1
BACK_UP_R5_3200 .BLKW #1
; BACK_UP_R6_3200 .BLKW #1
BACK_UP_R7_3200 .BLKW #1

.END
