;=================================================
; Name: Young, Christopher
; Email: cyoun069@ucr.edu
; 
; Lab: lab 1, ex 0
; Lab section: 025
; TA: Jang-Shing Enoch Lin
; 
;=================================================
.ORIG x3000
	;==============
	; Instructions
	;==============
	LEA R0, MSG_TO_PRINT
	PUTS
	
	HALT
	
	;==============
	;LOCAL DATA
	;==============
	MSG_TO_PRINT .STRINGZ "Hello World!!!\n"
	
.END
