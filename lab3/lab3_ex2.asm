;=================================================
; Name: Christopher Young
; Email: chrisyoung1048@gmail.com
; 
; Lab: lab 3, ex 2
; Lab section: 025
; TA: Jang-Shin Lin
; 
;=================================================

; Instructions
.orig x3000	
LD R1, ARRAY_1
LD R2, COUNT

DO_WHILE_LOOP
	GETC
	OUT
	ADD R1, R1, #1
	ADD R2, R2, #-1
	BRp DO_WHILE_LOOP
END_DO_WHILE_LOOP

HALT

; Local Data
ARRAY_1 .BLKW #10
COUNT .FILL #10

.end
