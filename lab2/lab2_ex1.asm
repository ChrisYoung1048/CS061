;=================================================
; Name: Christopher Young
; Email: cyoun069@ucr.edu
; 
; Lab: lab 2. ex 1
; Lab section: 025
; TA: Jang-Shin Lin
; 
;=================================================
.orig x3000
	; Instructions
	LD	R3,	DEC_65
	LD	R4,  HEX_41
	
	HALT
	; Local Data
	DEC_65 .FILL #65
	HEX_41 .FILL x41	
.END
