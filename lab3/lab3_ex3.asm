;=================================================
; Name: Christopher Young
; Email: chrisyoung1048@gmail.com
; 
; Lab: lab 3, ex 3
; Lab section: 025
; TA: Jang-Shin Lin
; 
;=================================================

; Instructions
.orig x3000	
LD R1, ARRAY_1 ;Set R1 to beginning of array
LD R2, COUNT ;Counter for array loop

DO_WHILE_LOOP
	GETC ;GETC stores ascii value into R0
	OUT
	ADD R1, R1, #1
	ADD R2, R2, #-1
	BRp DO_WHILE_LOOP
END_DO_WHILE_LOOP

LD R1, ARRAY_1 ;Reset R1 back to beginning of array
LD R2, COUNT

DO_WHILE_LOOP2
	GETC
	OUT
	LD R0, NEWLINE
	OUT
	ADD R1, R1, #1
	ADD R2, R2, #-1
	BRp DO_WHILE_LOOP2
END_DO_WHILE_LOOP2

HALT

; Local Data
ARRAY_1 .BLKW #10
COUNT .FILL #10
NEWLINE .FILL x0A

.end
