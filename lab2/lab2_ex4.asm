;=================================================
; Name: Christopher Young
; Email: cyoun069@ucr.edu
; 
; Lab: lab 2. ex 1
; Lab section: 025
; TA: Jang-Shin Lin
; 
;=================================================

;Instruction
.orig x3000

LD R0, HEX_61_PTR
LD R1, HEX_1A_PTR

lmaoloop
	OUT
	ADD R0, R0, #1
	ADD R1, R1, #-1
	BRp lmaoloop
END_DO_WHILE

HALT
;Local Data
HEX_61_PTR .FILL x61
HEX_1A_PTR .FILL x1A	

.end
