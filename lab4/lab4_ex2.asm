;=================================================
; Name: Christopher Young
; Email: cyoun069@ucr.edu
; 
; Lab: lab 4, ex 2
; Lab section: 025
; TA: Jang-Shin Lin
; 
;=================================================

.ORIG x3000
; Instruction

AND R1, R1, #0
LD R3, DATA_PTR
LOOP
	STR R1, R3, #0
	ADD R3, R3, #1
	ADD R1, R1, #1
	ADD R0, R1, #-10
	BRnp LOOP
END_LOOP
LD R3, DATA_PTR
AND R2, R2, #0
ADD R2, R2, #10
LOOP2
	LDR R0, R3, #0
	OUT
	ADD R3, R3, #1
	ADD R2, R2, #-1
	BRnp LOOP2
END_LOOP2
	
HALT

; Local Data
DATA_PTR .FILL ARRAY

; Remote Data
.ORIG x4000
ARRAY .BLKW #10


.END
