;=================================================
; Name: Christopher Young
; Email: cyoun069@ucr.edu
; 
; Lab: lab 4, ex 3
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
ADD R2, R2, #6
LDR R2, R2, #0

HALT
; Local Data
COUNTER .FILL #10
MULTIPLE_OF_TWO .FILL #1
DATA_PTR .FILL ARRAY
; Remote Data
.ORIG x4000
ARRAY .BLKW #10

.END
