;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Christopher Young
; Email: cyoun069@ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: 025
; TA: Jang-Shin Lin
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R2
;=================================================================================

					.ORIG x3000		
;-------------
;Instructions
;-------------

					; output intro prompt
					RESTART
						LD R0, introPromptPtr
						PUTS
					; Set up flags, counters, accumulators as needed
					AND R4, R4, #0 ; Accumulator for sum
					AND R5, R5, #0 ; Digit counter
					AND R6, R6, #0 ; R6 set to negative flag
					; Get first character, test for '\n', '+', '-', digit/non-digit 
					FIRST_CHARACTER
						GETC
						OUT
						; is very first character = '\n'? if so, just quit (no message)!
						LD R1, convert_char_newline 
						ADD R1, R1, R0
						BRz END
						
						; is it = '+'? if so, ignore it, go get digits
						LD R1, convert_char_plus
						ADD R1, R1, R0
						BRz CHECK_DIGIT
 						
 						; is it = '-'? if so, set neg flag, go get digits
						LD R1, convert_char_minus 
						ADD R1, R1, R0 
						BRz NEGATIVE_SIGN
						
					BR CHECK_DIGIT_SKIP
						
					NEGATIVE_SIGN
						ADD R6, R6, #1
						BRz CHECK_DIGIT
						
					CHECK_DIGIT
						GETC
						OUT
						CHECK_DIGIT_SKIP
						
						LD R1, convert_char_newline 
						ADD R1, R1, R0
						BRz FINALIZE_SIGN
						
						; is it < '0'? if so, it is not a digit	- o/p error message, start over
						LD R1, char_0
						NOT R1, R1
						ADD R1, R1, #1 ; Set R2 to negative  
						ADD R1, R0, R1 ; R0 - R1 (input character - character '0')
						BRn ERROR_MESSAGE
 						
 						; is it > '9'? if so, it is not a digit	- o/p error message, start over
 						LD R1, char_9
 						NOT R1, R1
 						ADD R1, R1, #1 
 						ADD R1, R0, R1 ; R0 - R1 (input character - character '9')
						BRp ERROR_MESSAGE
						
						; if none of the above, first character is first numeric digit - convert it to number & store in target register!
						LD R1, from_ascii
						ADD R1, R1, R0 ; Convert character to decimal
						
						AND R0, R0, #0
						ADD R0, R0, R4
						ADD R0, R0, R4
						ADD R0, R0, R4
						ADD R0, R0, R4
						ADD R0, R0, R4
						ADD R0, R0, R4
						ADD R0, R0, R4
						ADD R0, R0, R4
						ADD R0, R0, R4
						ADD R0, R0, R4
						
						AND R4, R4, #0
						ADD R4, R4, R0 ; Add decimal to accumulator register
						ADD R4, R4, R1
						ADD R5, R5, #1 ; Increment digit counter
						
					
; Now get remaining digits (max 5) from user, testing each to see if it is a digit, and build up number in accumulator

					GET_DIGITS
						ADD R1, R5, #-5
						BRz END_GET_DIGITS
						
						BR CHECK_DIGIT
					
					ERROR_MESSAGE
						LD R0, char_newline
						OUT
						LD R0, errorMessagePtr
						PUTS
						BR RESTART
						
					END_GET_DIGITS
						LD R0, char_newline
						OUT
						
					FINALIZE_SIGN	
						ADD R6, R6, #0 ; LMR
						BRz POSITIVE
						NOT R4, R4
						ADD R4, R4, #1 ; Convert to negative if negative flag is 1ution
						
					POSITIVE

					; remember to end with a newline!
					END
						;LD R0, char_newline
						;OUT
						AND R2, R2, R0
						ADD R2, R2, R4
					
					HALT

;---------------	
; Program Data
;---------------
introPromptPtr		.FILL xA100
errorMessagePtr		.FILL xA200

from_ascii			.FILL #-48

convert_char_newline .FILL #-10
convert_char_plus .FILL #-43
convert_char_minus .FILL #-45

char_0 .FILL x30
char_9 .FILL x39
char_newline .FILL x0A

;------------
; Remote data
;------------
					.ORIG xA100			; intro prompt
					.STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
					
					
					.ORIG xA200			; error message
					.STRINGZ	"ERROR: invalid input\n"

;---------------
; END of PROGRAM
;---------------
					.END

;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.
