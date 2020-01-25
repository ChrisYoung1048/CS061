;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Christopher Young
; Email: cyoun069@ucr.edu	
; 
; Assignment name: Assignment 2
; Lab section: 025
; TA: Jang-Shin Lin
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------

;----------------------------------------------
;output prompt
;----------------------------------------------	
LEA R0, intro			; get starting address of prompt string
PUTS			    	; Invokes BIOS routine to output string

;-------------------------------
;INSERT YOUR CODE here
;--------------------------------
; store and echo first character
GETC
OUT
ADD R1,	R0,	#0
LD R0, newline
OUT
; store and echo second character
GETC
OUT
ADD	R2,	R0,	#0
LD R0, newline
OUT
; output full expression
ADD R0, R1, #0
OUT
LEA R0, minus_sign
PUTS
ADD R0, R2, #0
OUT
LEA R0, equals_sign
PUTS
; convert ascii(decimal value) to number
ADD R1, R1, #-15
ADD R1, R1, #-15
ADD R1, R1, #-15
ADD R1, R1, #-3
ADD R2, R2, #-15
ADD R2, R2, #-15
ADD R2, R2, #-15
ADD R2, R2, #-3
; convert second value to negative
NOT R2, R2
ADD R2, R2, #1
; add values together
ADD R3, R1, R2
; check sign to branch
ADD R3, R3, #0 ;R3 = LMR
BRn negative_sum
ADD R3, R3, #0
BRzp positive_sum
; if sum is negative
negative_sum
	LD R0, negative_sign ;add negative sign
	OUT
	NOT R3, R3 ;switch signs
	ADD R3, R3, #1
	ADD R3, R3, #15 ;convert back to ascii
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #3
	ADD R0, R3, #0
	OUT
	BRzp end_condition 
positive_sum
	ADD R3, R3, #15 ;convert back to ascii
	ADD R3, R3, #15
	ADD R3, R3, #15
	ADD R3, R3, #3
	ADD R0, R3, #0
	OUT
	BRzp end_condition 
end_condition
	LD R0, newline
	OUT
HALT				; Stop execution of program
;------	
;Data
;------
; String to prompt user. Note: already includes terminating newline!
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
newline .FILL '\n'	; newline character - use with LD followed by OUT
minus_sign	.STRINGZ " - "
equals_sign	.STRINGZ " = "
negative_sign .FILL x2D
;---------------	
;END of PROGRAM
;---------------	
.END

