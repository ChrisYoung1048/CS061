;=================================================
; Name: Christopher Young
; Email: cyoun069@ucr.edu
; 
; Lab: lab 5, ex 2
; Lab section: 025
; TA: Jang-Shin Lin
; 
;=================================================

.ORIG x3000

; Instruction
LEA R0, MSG_TO_PRINT
PUTS
GETC ; Store B
OUT
AND R0, R0, #0 ; Empty B 

LD R6, SUBROUTINE_INPUT_TO_DECIMAL_3400
JSRR R6

LD R6, SUBROUTINE_DECIMAL_TO_BINARY_3200
JSRR R6

HALT
; Local Data
MSG_TO_PRINT .STRINGZ "Enter a 16-bit 2's compliment binary number.\nExample: b0000000000000000\n"
SUBROUTINE_DECIMAL_TO_BINARY_3200 .FILL x3200
SUBROUTINE_INPUT_TO_DECIMAL_3400 .FILL x3400
;=======================================================================
; Subroutine: SUBROUTINE_DECIMAL_TO_BINARY_3200
; Parameter: (R1”): Decimal to convert to 16-bit Binary 
; Postcondition: Prints out a 16-bit binary converted from R1 (decimal form)
; Return Value: There is no return value since the function prints
;=======================================================================
; Subroutine Instruction
.ORIG x3200

	; 1) Backup
ST R0, BACK_UP_R0_3200
ST R1, BACK_UP_R1_3200
ST R2, BACK_UP_R2_3200
ST R3, BACK_UP_R3_3200
ST R4, BACK_UP_R4_3200
ST R7, BACK_UP_R7_3200
	
	; 2) Instruction
LD R2, Size ; R2 stores loop counter

DO_WHILE_LOOP
	ADD R1, R1, #0 ; Set R1 to LMR
	BRp IF_MSB_POSITIVE
	BRn IF_MSB_NEGATIVE

IF_MSB_POSITIVE
	LD R0, Decimal_48
	OUT
	BRnzp IF_SHIFT
	
IF_MSB_NEGATIVE
	LD R0, Decimal_49
	OUT
	BRnzp IF_SHIFT
	
IF_SHIFT
	ADD R1, R1, R1 ; Shift binary left
	ADD R2, R2, #-1 ; Decrement counter
	BRz END_LOOP
	ADD R3, R2, #-12 
	BRz OUT_SPACE
	ADD R3, R2, #-8 
	BRz OUT_SPACE
	ADD R3, R2, #-4 
	BRz OUT_SPACE
	BRnzp DO_WHILE_LOOP
	
OUT_SPACE
	LD R0, Space_char
	OUT
	BRnzp DO_WHILE_LOOP
	
END_LOOP
	LD R0, Newline_char
	OUT
	
	; 3) Restore
LD R0, BACK_UP_R0_3200
LD R1, BACK_UP_R1_3200
LD R2, BACK_UP_R2_3200
LD R3, BACK_UP_R3_3200
LD R4, BACK_UP_R4_3200
LD R7, BACK_UP_R7_3200

	; 4) Return
	ret
	
; Subroutine Local Data
Newline_char .FILL x0A
Space_char .FILL x20
Decimal_48 .FILL #48 ; ASCII Value for 0
Decimal_49 .FILL #49 ; ASCII Value for 1
Size .FILL #16 ; Loop Counter

BACK_UP_R0_3200 .BLKW #1
BACK_UP_R1_3200 .BLKW #1
BACK_UP_R2_3200 .BLKW #1
BACK_UP_R3_3200 .BLKW #1
BACK_UP_R4_3200 .BLKW #1
BACK_UP_R7_3200 .BLKW #1

;=======================================================================
; Subroutine: SUBROUTINE_INPUT_TO_DECIMAL_3400
; Parameter: No parameter, input is taken directly from R0 
; Postcondition: Returns a decimal sum
; Return Value: R1, which is the decimal sum of the binary
;=======================================================================
; Subroutine Instruction
.ORIG x3400
	; 1) Backup
ST R0, BACK_UP_R0_3400
ST R2, BACK_UP_R2_3400
ST R3, BACK_UP_R3_3400
ST R4, BACK_UP_R4_3400
ST R7, BACK_UP_R7_3400
	; 2) Instruction
LD R3, READ_LOOP_SIZE
AND R1, R1, #0
LD R4, Decimal_Neg_48
READ_LOOP
	GETC
	OUT
	ADD R1, R1, R1
	ADD R0, R0, R4
	BRp ADD_1
	BRnz END_READ_LOOP
	ADD_1
		ADD R1, R1, #1

	END_READ_LOOP
		ADD R3, R3, #-1
	BRp READ_LOOP
	
	LD R0, Newline_char2
	OUT

	; 3) Restore
LD R0, BACK_UP_R0_3400
LD R2, BACK_UP_R2_3400
LD R3, BACK_UP_R3_3400
LD R4, BACK_UP_R4_3400
LD R7, BACK_UP_R7_3400
	; 4) Return
	ret 
; Subroutine Local Data
READ_LOOP_SIZE .FILL #16 ; Loop Counter
Decimal_Neg_48 .FILL #-48
Newline_char2 .FILL x0A

BACK_UP_R0_3400 .BLKW #1
BACK_UP_R2_3400 .BLKW #1
BACK_UP_R3_3400 .BLKW #1
BACK_UP_R4_3400 .BLKW #1
BACK_UP_R7_3400 .BLKW #1

.END
