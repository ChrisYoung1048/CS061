;=================================================
; Name: Christopher Young
; Email: cyoun069@ucr.edu
; 
; Lab: lab 5, ex 1
; Lab section: 025
; TA: Jang-Shin Lin
; 
;=================================================

.ORIG x3000

; Instruction
LD R1, MULTIPLE_OF_TWO
LD R2, DATA_PTR
LD R3, COUNTER

LOOP
	STR R1, R2, #0
	ADD R1, R1, R1
	ADD R2, R2, #1
	ADD R3, R3, #-1
	BRnp LOOP
END_LOOP

LD R2, DATA_PTR
LD R3, COUNTER

LOOP2
	LDR R1, R2, #0 ; Take thDecimal to convert to 16-bit Binary e value of R2 for testing
	LD R7, SUB_CONVERT_BINARY_3200 ; Load subroutine
	JSRR R7 ; Call Subroutine
	ADD R2, R2, #1
	ADD R3, R3, #-1
	BRnp LOOP2
END_LOOP2
HALT

; Local Data
SUB_CONVERT_BINARY_3200 .FILL x3200
DECIMAL_48 .FILL #0 ; Set this to 48
QUOTEMARK .FILL #34
NEWLINE .FILL #10
COUNTER .FILL #10
MULTIPLE_OF_TWO .FILL #1
DATA_PTR .FILL ARRAY

; Remote Data
.ORIG x4000
ARRAY .BLKW #10

;=======================================================================
; Subroutine: SUB_CONVERT_BINARY_3200
; Parameter: (R1): Decimal to print in Binary
; Postcondition: Prints out a 16-bit binary converted from R1 (decimal form)
; Return Value: There is no return value since the function prints
;=======================================================================
; Subrountine Instruction
.ORIG x3200

	; 1) back up affected registers
ST R0, BACK_UP_R0_3200
ST R1, BACK_UP_R1_3200
ST R2, BACK_UP_R2_3200
ST R3, BACK_UP_R3_3200
ST R7, BACK_UP_R7_3200

	; 2) algorithm
LD R2, Decimal_16 ; R2 stores loop counter

SUBLOOP
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
	BRz END_SUBLOOP
	ADD R3, R2, #-12 
	BRz OUT_SPACE
	ADD R3, R2, #-8 
	BRz OUT_SPACE
	ADD R3, R2, #-4 
	BRz OUT_SPACE
	BRnzp SUBLOOP
	
OUT_SPACE
	LD R0, Space_char
	OUT
	BRnzp SUBLOOP
	
END_SUBLOOP
	LD R0, Newline_char
	OUT

	; 3) restore affected registers
LD R0, BACK_UP_R0_3200
LD R1, BACK_UP_R1_3200
LD R2, BACK_UP_R2_3200
LD R3, BACK_UP_R3_3200
LD R7, BACK_UP_R7_3200

	; 4) return 
ret

; Subroutine Data
Newline_char .FILL x0A
Space_char .FILL x20
Decimal_48 .FILL #48 ; ASCII Value for 0
Decimal_49 .FILL #49 ; ASCII Value for 1
Decimal_16 .FILL #16 ; Loop Counter

BACK_UP_R0_3200 .BLKW #1
BACK_UP_R1_3200 .BLKW #1
BACK_UP_R2_3200 .BLKW #1
BACK_UP_R3_3200 .BLKW #1
BACK_UP_R7_3200 .BLKW #1

.END
