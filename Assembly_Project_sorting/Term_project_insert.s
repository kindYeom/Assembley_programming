	AREA code_area, CODE, READONLY
		ENTRY

float_number_series EQU 0x0450
sorted_number_series EQU 0x00018AEC
final_result_series EQU 0x00031190

;========== Do not change this area ===========

initialization
	LDR r0, =0xDEADBEEF				; seed for random number
	LDR r1, =float_number_series	
	LDR r2, =10000  				; The number of element in stored sereis
	LDR r3, =0x0EACBA90				; constant for random number

save_float_series
	CMP r2, #0
	BEQ is_init
	BL random_float_number
	STR r0, [r1], #4
	SUB r2, r2, #1
	MOV r5, #0
	B save_float_series

random_float_number
	MOV r5, LR
	EOR r0, r0, r3
	EOR r3, r0, r3, ROR #2
	CMP r0, r1
	BLGE shift_left
	BLLT shift_right
	BX r5

shift_left
	LSL r0, r0, #1
	BX LR

shift_right
	LSR r0, r0, #1
	BX LR
	
;============================================

;========== Start your code here ===========

	
is_init
	LDR r7, =final_result_series ; where result saved
	LDR r0, =final_result_series ; where result saved
	LDR r1, =float_number_series ; where data exist
	LDR r2,=10000 ; inserted num
	LDR r12,[r1],#4 ; first data get
	str r12,[r0]; first save
	mov r3,#0 ; data count
	LDR R13,=0x7FFFFFFF
	B is_play ; start

insert_before
	STR r12,[r0,#-4]
	
is_play
	ADD r3,r3,#1 ;; count up
	mov r0,r7 ; get data start
	cmp r2,r3 ; end of programming
	BEQ final_1 ; when comapre are over
	LDR r12,[r1],#4 ; call data to compare
	LSR r8,r12,#31 ; get sign
	LSL R9,R12,#1 ; get extend
	LSR R9,R9,#24 
	cmp R9,#255 ; to check not a number or infite
	and r10,r12,r13 ; get others
	BEQ inf ; inifite
	mov r4,#0 ; start zero

cmp_signed
	cmp r4,r3 ; 
  	BEQ insert_end ; if r3 =r4 program end
	LDR R11,[r0],#4 ; get data
	LSR R5,R11,#31 ; get sign
	cmp R8,R5;compare sign bit
	BEQ cmp_ex; if sign bit same compare ex

	ADDMI r4,r4,#1 ; if sign bit is lower then cmopare next
	BMI cmp_signed
	SUB r0,r0,#4
	B insert_bet; otehr is here to insert
	
get_next_data
	ADD r4,r4,#1 ; get next data
	LDR R11,[r0],#4 ; get data
	
cmp_ex; compare expontial
	cmp r4,r3; the end of arr
	BEQ insert_before;
	cmp R8,#1; sign is 1 or 0
	and r5,r11,r13 ; get ex and mantisa
	BEQ cmp_ex_neg ; if negative
	cmp R10,R5	; sign is 1 ->com pare 
	BLPL get_next_data; bigger next
	SUB r0,r0,#4
	
insert_bet ; insert between
	cmp r3,r4
	BMI is_play
	SWP r12,r12,[r0]
	ADD r4,r4,#1
	ADD r0,r0,#4
	B insert_bet

cmp_ex_neg ; compare when neg

	cmp R10,R5
	ADDMI r4,r4,#1
	BMI cmp_signed
	sub r0,r0,#4
	B insert_bet
	
insert_end ; insert end of arr
	STR r12,[r0]
	B is_play
	
inf	; if inf
	cmp r8,#1
	MOV r4,#0
	BEQ inf_M ; is minus
	
	sub r2,r2,#1
	LSL r5,r2,#2
	STR r12,[r0,r5]
	sub r3,r3,#1
	B is_play
	
inf_M ;minus inf
	cmp r3,r4
	BMI inf_end
	SWP r12,r12,[r0]
	ADD r4,r4,#1
	ADD r0,r0,#4
	B inf_M
inf_end	; inser end
	sub r2,r2,#1
	sub r3,r3,#1
	add r7,r7,#4
	B is_play
	
	

	
final_1; compare inf and NaN
	LDR r0, =final_result_series
final_re1	  ; repeat final 1
	cmp r0,r7
	BPL	final_2
	LDR r1,[r0]
	LSL r2,r1,#9
	cmp r2,#0
	ADDNE r0,#4
	BNE final_re1 ; compare next
	swp r1,r1,[r7]
	STR r1,[r0]	
	sub r7,r7,#4
	B final_re1
final_2	; compare inf and NaN
	LDR r12, =final_result_series
	LDR r8,=0x9c3c
	LDR r11,=0x7F800000
	ADD r7,r12,r8
	mov r0,r7
	
final_re2	;repeat final 2
	LDR r1,[r0]
	cmp r1,r11
	BMI exit
	SWPNE r1,r1,[r7]
	SUBNE r7,r7,#4
	STRNE r1,[r0]
	SUB r0,#4
	B final_re2
	
exit	

	MOV pc, #0 ;Program end
	END

;========== End your code here ===========