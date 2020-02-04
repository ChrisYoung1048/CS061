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
	LDI	R3,	DEC_65_PTR
	LDI	R4, HEX_41_PTR
	
	ADD R3, R3, #1
	ADD R4, R4, #1
	
	STI R3, DEC_65_PTR
	STI R4, HEX_41_PTR
	
	HALT
	; Local Data
	DEC_65_PTR .FILL x4000
	HEX_41_PTR .FILL x4001
	
	; Remote Data
	.orig x4000
	NEW_DEC_65 .FILL #65		
	NEW_HEX_41 .FILL x41
.END
