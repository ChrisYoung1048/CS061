;=================================================
; Name: Christopher Young
; Email: cyoun069@ucr.edu
; 
; Lab: lab 4, ex 4
; Lab section: 025
; TA: Jang-Shin Lin
; 
;=================================================

.ORIG x3000
; Instruction
LD R1, MULTIPLE_OF_TWO
LD R2, DATA_PTR
LD R3, COUNTER
;LD R4, DECIMAL_48

;ADD R4, R4, #12
;ADD R4, R4, #12
;ADD R4, R4, #12
;ADD R4, R4, #12

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
	LD R0, QUOTEMARK
	OUT
	LDR R0, R2, #0
	ADD R0, R0, R4
	OUT
	LD R0, QUOTEMARK
	OUT
	LD R0, NEWLINE
	OUT
	ADD R2, R2, #1
	ADD R3, R3, #-1
	BRnp LOOP2
END_LOOP2

HALT
; Local Data
DECIMAL_48 .FILL #0 ; Set this to 48
QUOTEMARK .FILL #34
NEWLINE .FILL #10
COUNTER .FILL #10
MULTIPLE_OF_TWO .FILL #1
DATA_PTR .FILL ARRAY
; Remote Data
.ORIG x4000
ARRAY .BLKW #10

.END
