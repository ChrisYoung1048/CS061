;=================================================
; Name: Christopher Young
; Email: cyoun069@ucr.edu
; 
; Lab: lab 6, ex 1
; Lab section: 025
; TA: Jang-Shin Lin
; 
;=================================================

;----------------------------------------------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameter (R1): The starting address of the character array
; Postcondition: The subroutine has prompted the user to input a string,
; terminated by the [ENTER] key (the "sentinel"), and has stored
; the received characters in an array of characters starting at (R1).
; the array is NULL-terminated; the sentinel character is NOT stored.
; Return Value (R5): The number of non-sentinel characters read from the user.
; R1 contains the starting address of the array unchanged.
;-----------------------------------------------------------------------------------------------------------------
.ORIG x3200
SUB_GET_STRING

; Backup Registers

ST R0, BACK_UP_R0_3200
ST R1, BACK_UP_R1_3200
ST R2, BACK_UP_R2_3200
ST R3, BACK_UP_R3_3200
ST R7, BACK_UP_R7_3200

; Subroutine Instruction
LEA R0, MSG
PUTS

AND R5, R5, 0 ; Set R5 as counter for number of characters entered
LD R3, ascii_enter ; Set R3 to decimal value for enter ascii

READ_LOOP
	GETC
	OUT
	ADD R2, R0, R3
	BRz END_READ_LOOP
	STR R0, R1, #0 ; Store value through pointer R1
	ADD R1, R1, #1 ; Traverse array 
	ADD R5, R5, #1
	BR READ_LOOP

END_READ_LOOP
	LD R0, decimal_0
	STR R0, R1, #0
	
; Restore Registers 
LD R0, BACK_UP_R0_3200
LD R1, BACK_UP_R1_3200
LD R2, BACK_UP_R2_3200
LD R3, BACK_UP_R3_3200
LD R7, BACK_UP_R7_3200

; Return
RET ; R5 is returned

; Subroutine Data
ascii_enter .FILL #-10 
decimal_0 .FILL #0

MSG .STRINGZ "Enter a string of text. Press enter to finish.\n"

BACK_UP_R0_3200 .BLKW #1
BACK_UP_R1_3200 .BLKW #1
BACK_UP_R2_3200 .BLKW #1
BACK_UP_R3_3200 .BLKW #1
BACK_UP_R7_3200 .BLKW #1

.END
