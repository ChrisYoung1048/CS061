;=================================================
; Name: Christopher Young
; Email: chrisyoung1048@gmail.com
; 
; Lab: lab 3, ex 4
; Lab section: 025
; TA: Jang-Shin Lin
; 
;=================================================

; Instructions
.orig x3000	
LD R1, DATA_PTR ;Set R1 to beginning of array

LOOP
	GETC ;GETC stores ascii value into R0
	OUT
	STR R0, R1, #0 ;store address of ascii into r1
	ADD R1, R1, #1 ;increment
	ADD R0, R0, #-10 ;check for newline
	BRnp LOOP
END_LOOP

LD R1, DATA_PTR ;Reset R1 back to beginning of array

LOOOP
	LDR R0, R1, #0
	OUT
	ADD R2, R0, #0 ;Store value into R1
	LD R0, NEWLINE
	OUT
	ADD R1, R1, #1
	ADD R2, R2, #-10 ;check for newline
	BRnp LOOOP
END_LOOOOOOOP

HALT

; Local Data 
DATA_PTR .FILL x4000
NEWLINE .FILL x0A

.end
