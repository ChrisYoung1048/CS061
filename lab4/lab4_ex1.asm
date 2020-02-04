;=================================================
; Name: Christopher Young
; Email: cyoun069@ucr.edu
; 
; Lab: lab 4, ex 1
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
ADD R3, R3, #6
LDR R2, R3, #0
	
	
HALT

; Local Data
DATA_PTR .FILL ARRAY

; Remote Data
.ORIG x4000
ARRAY .BLKW #10


.END
