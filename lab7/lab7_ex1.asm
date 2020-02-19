;=================================================
; Name: Christopher Young
; Email: cyoun069@ucr.edu
; 
; Lab: lab 7, ex 1
; Lab section: 025
; TA: Jang-Shin Lin
; 
;=================================================
.ORIG x3000	

; Instruction
LD R1, SUB_STORE_DECIMAL_TO_REGISTER
JSRR R1 ; Subroutine converts user input into decimal and stores into register R2

ADD R2, R2, #1 ; Add 1 to R2

LD R0, CHARACTER_NEWLINE
OUT

LD R1, SUB_CONVERT_REGISTER_TO_CHARACTER
JSRR R1

HALT 
; Local Data
CHARACTER_NEWLINE .FILL x0A

SUB_STORE_DECIMAL_TO_REGISTER .FILL x3200
SUB_CONVERT_REGISTER_TO_CHARACTER .FILL x3400
;------------------------------------------------------------------------------------------------------------------
; Subroutine: SUB_STORE_DECIMAL_TO_REGISTER
; Parameter (None): The subroutine directly takes from user input
; Postcondition: The subroutine has stored user inputted characters into register as a decimal
; Return Value: R2 Decimal form of user inputted characters
;------------------------------------------------------------------------------------------------------------------
.ORIG x3200
; SUB_STORE_DECIMAL_TO_REGISTER

; Backup Registers
ST R0, BACK_UP_R0_3200
ST R1, BACK_UP_R1_3200
; ST R2, BACK_UP_R2_3200
ST R3, BACK_UP_R3_3200
ST R4, BACK_UP_R4_3200
ST R5, BACK_UP_R5_3200
ST R6, BACK_UP_R6_3200•••••••••••••••
ST R7, BACK_UP_R7_3200

;-------------
;Subroutine Instructions
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
	BRz END_SUB
	
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
	NOT R1, R1•••••••••••••••
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
END_SUB
	;LD R0, char_newline
	;OUT
	AND R2, R2, R0
	ADD R2, R2, R4
	
; Restore Registers
LD R0, BACK_UP_R0_3200
LD R1, BACK_UP_R1_3200
; LD R2, BACK_UP_R2_3200
LD R3, BACK_UP_R3_3200
LD R4, BACK_UP_R4_3200
LD R5, BACK_UP_R5_3200
LD R6, BACK_UP_R6_3200
LD R7, BACK_UP_R7_3200

; Return
RET

;---------------	
; Subroutine Data
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


BACK_UP_R0_3200 .BLKW #1
BACK_UP_R1_3200 .BLKW #1
; BACK_UP_R2_3200 .BLKW #1
BACK_UP_R3_3200 .BLKW #1
BACK_UP_R4_3200 .BLKW #1
BACK_UP_R5_3200 .BLKW #1
BACK_UP_R6_3200 .BLKW #1
BACK_UP_R7_3200 .BLKW #1

;------------
; Subroutine Remote data
;------------
.ORIG xA100			; intro prompt
.STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"


.ORIG xA200			; error message
.STRINGZ	"ERROR: invalid input\n"

;------------------------------------------------------------------------------------------------------------------
; Subroutine: SUB_CONVERT_REGISTER_TO_CHARACTER (Only works for Unsigned Decimals)
; Parameter: R2 Decimal form of user inputted characters
; Postcondition: The subroutine has printed out the decimal of R2 in character form
; Return Value (None): This subroutine prints out characters
;------------------------------------------------------------------------------------------------------------------
.ORIG x3400

; Backup Registers
ST R0, BACK_UP_R0_3400
ST R1, BACK_UP_R1_3400
ST R2, BACK_UP_R2_3400
ST R3, BACK_UP_R3_3400
ST R4, BACK_UP_R4_3400
ST R5, BACK_UP_R5_3400
ST R6, BACK_UP_R6_3400
ST R7, BACK_UP_R7_3400

; Subroutine Instruction
AND R1, R1, #0 ; Clear R1s
ADD R1, R1, R2 ; Copy R2 to R1

AND R3, R3, #0 ; Clear R3 (Used to acumulate digit to print)
LD R4, decimal_neg_10000

DIGIT_5
	ADD R1, R1, R4 ; Subtract target decimal by 10000
	BRn DIGIT_5_NEGATIVE ; If result is negative, end loop
	ADD R3, R3, #1 ; If result is positive, increment count by 1 and continue loop
	BR DIGIT_5
	
DIGIT_5_NEGATIVE
	NOT R4, R4
	ADD R4, R4, #1
	ADD R1, R1, R4 ; Revert last subtraction to keep R1 positive
	AND R0, R0, #0 ; Clear R0
	ADD R0, R0, R3 ; Copy R3 to R0 in order to print
	LD R4, to_ascii
	ADD R0, R0, R4 ; Convert value to printable character
	OUT
	
AND R3, R3, #0 ; Clear R3 
LD R4, decimal_neg_1000

DIGIT_4
	ADD R1, R1, R4 ; Subtract target decimal by 1000
	BRn DIGIT_4_NEGATIVE ; If result is negative, end loop
	ADD R3, R3, #1 ; If result is positive, increment count by 1 and continue loop
	BR DIGIT_4
	
DIGIT_4_NEGATIVE
	NOT R4, R4
	ADD R4, R4, #1
	ADD R1, R1, R4 ; Revert last subtraction to keep R1 positive
	AND R0, R0, #0 ; Clear R0
	ADD R0, R0, R3 ; Copy R3 to R0 in order to print
	LD R4, to_ascii
	ADD R0, R0, R4 ; Convert value to printable character
	OUT
	
AND R3, R3, #0 ; Clear R3 
LD R4, decimal_neg_100

DIGIT_3
	ADD R1, R1, R4 ; Subtract target decimal by 100
	BRn DIGIT_3_NEGATIVE ; If result is negative, end loop
	ADD R3, R3, #1 ; If result is positive, increment count by 1 and continue loop
	BR DIGIT_3
	
DIGIT_3_NEGATIVE
	NOT R4, R4
	ADD R4, R4, #1
	ADD R1, R1, R4 ; Revert last subtraction to keep R1 positive
	AND R0, R0, #0 ; Clear R0
	ADD R0, R0, R3 ; Copy R3 to R0 in order to print
	LD R4, to_ascii
	ADD R0, R0, R4 ; Convert value to printable character
	OUT
	
AND R3, R3, #0 ; Clear R3 
	
DIGIT_2
	ADD R1, R1, #-10 ; Subtract target decimal by 10
	BRn DIGIT_2_NEGATIVE ; If result is negative, end loop
	ADD R3, R3, #1 ; If result is positive, increment count by 1 and continue loop
	BR DIGIT_2
	
DIGIT_2_NEGATIVE
	ADD R1, R1, #10 ; Revert last subtraction to keep R1 positive
	AND R0, R0, #0 ; Clear R0
	ADD R0, R0, R3 ; Copy R3 to R0 in order to print
	LD R4, to_ascii
	ADD R0, R0, R4 ; Convert value to printable character
	OUT

AND R3, R3, #0 ; Clear R3 
	
DIGIT_1
	ADD R1, R1, #-1 ; Subtract target decimal by 1
	BRn DIGIT_1_NEGATIVE ; If result is negative, end loop
	ADD R3, R3, #1 ; If result is positive, increment count by 1 and continue loop
	BR DIGIT_1
	
DIGIT_1_NEGATIVE
	ADD R1, R1, #1 ; Revert last subtraction to keep R1 positive
	AND R0, R0, #0 ; Clear R0
	ADD R0, R0, R3 ; Copy R3 to R0 in order to print
	LD R4, to_ascii
	ADD R0, R0, R4 ; Convert value to printable character
	OUT

; Restore Registers
LD R0, BACK_UP_R0_3400
LD R1, BACK_UP_R1_3400
LD R2, BACK_UP_R2_3400
LD R3, BACK_UP_R3_3400
LD R4, BACK_UP_R4_3400
LD R5, BACK_UP_R5_3400
LD R6, BACK_UP_R6_3400
LD R7, BACK_UP_R7_3400

; Return
RET

; Subroutine Data
decimal_neg_10000 .FILL #-10000
decimal_neg_1000 .FILL  #-1000
decimal_neg_100 .FILL	#-100

to_ascii .FILL #48

BACK_UP_R0_3400 .BLKW #1
BACK_UP_R1_3400 .BLKW #1
BACK_UP_R2_3400 .BLKW #1
BACK_UP_R3_3400 .BLKW #1
BACK_UP_R4_3400 .BLKW #1
BACK_UP_R5_3400 .BLKW #1
BACK_UP_R6_3400 .BLKW #1
BACK_UP_R7_3400 .BLKW #1

;---------------
; END of PROGRAM
;---------------
.END
