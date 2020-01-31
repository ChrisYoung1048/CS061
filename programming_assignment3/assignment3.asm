;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Christopher Young
; Email: cyoun069@ucr.edu
; 
; Assignment name: Assignment 3
; Lab section: 025
; TA: Jang-Shin Lin
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
LD R6, Value_addr		; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
LD R2, Decimal_16 ; R2 stores loop counter

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

HALT

;---------------	
;Data
;---------------
Value_addr	.FILL xB800	; The address where value to be displayed is stored
Newline_char .FILL x0A
Space_char .FILL x20
Decimal_48 .FILL #48 ; ASCII Value for 0
Decimal_49 .FILL #49 ; ASCII Value for 1
Decimal_16 .FILL #16 ; Loop Counter
;Decimal_Negative_12 .FILL #-12 ; Check for space 1
;Decimal_Negative_8 .FILL #-8 ; Check for space 2
;Decimal_Negative_4	 .FILL #-4 ; Check for space 3


.ORIG xB800					; Remote data
Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
;---------------	
;END of PROGRAM
;---------------	
.END
