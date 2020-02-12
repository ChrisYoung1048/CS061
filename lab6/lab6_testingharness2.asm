; ================
; Testing Harness 2
; ================
.ORIG x3000

; Instruction
LD R1, DATA_POINTER ; (Parameter) Address to pass in

LD R2, SUB_GET_STRING
JSRR R2

LD R2, SUB_IS_A_PALINDROME
JSRR R2

HALT

; Local Data
DATA_POINTER .FILL x4000
SUB_GET_STRING .FILL x3200
SUB_IS_A_PALINDROME .FILL x3400

.END
