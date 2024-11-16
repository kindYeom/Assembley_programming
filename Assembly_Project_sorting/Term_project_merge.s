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
	BEQ ms_init
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sign_and EQU 0x7fffffff


ms_init
	LDR r0, =final_result_series ; where result saved 
	mov r2,#1; now we compare data
	LDR r3, =float_number_series ; where data exist and data saved
	LDR r11, = 0x7F800000 ; 
	add r12,r0,r1,LSL #2
	LDR R13,=0x7fffffff
		
ms_arr1_to_arr2
	LDR r1, =10000   ;; TOTAL DATA
	LSL r2,#1 ; num of sorted data
	cmp r2,#2 
	MOVEQ r2,#1 
	CMP R1,R2;CAN SORT more
	LDRMI r3,=float_number_series
	BMI load
	
	LDR r3, =float_number_series ; where data exist
	LDR r5, =sorted_number_series ; where data sorted
ms_arr1_to_arr2_set
	CMP R1,#0 ; COMPARE IS OVER?
	BEQ ms_arr2_to_arr1 ; SOROTED OVER
	mov r6,r2 ; COMPARED NUM
	mov r7,r2 ; COMPARED NUM
	add r4,r3,r2,LSL #2 ; where sub arr start r3 & r4
	cmp r1,r2,LSL#1
	BLMI remain_sorted
ms_arr1_to_arr2_re	
	cmp r6,#0 ; sub arr 1 empty
	BEQ remain_r7
	cmp r7,#0 ;  sub arr 1 empty
	BEQ remain_r6
	ldr r8,[r3] ; getdata
	ldr r9,[r4] ; getdata
	BL cmp_sign ; cmp data
	STR r13,[r5],#4	; insert
	SUB R1,#1 ; minus total 
	B ms_arr1_to_arr2_re

ms_arr2_to_arr1
	LDR r1, =10000  
	LSL r2,#1 ; num of sorted data
	CMP R1,R2 ;CAN SORT sort more
	LDRMI r3,=sorted_number_series
	BMI load
	
	LDR r3, =sorted_number_series ; where data exist
	LDR r5, =float_number_series ; where data sorted
	
ms_arr2_to_arr1_set
	CMP R1,#0 ; COMPARE IS OVER?
	BEQ ms_arr1_to_arr2 ; SOROTED OVER	
	
	mov r6,r2 ; COMPARED NUM
	mov r7,r2 ; COMPARED NUM
	add r4,r3,r2,LSL #2 ; where data start ->r4,r3
	cmp r1,r2,LSL#1
	BLMI remain_sorted
	
ms_arr2_to_arr1_re	
	cmp r6,#0
	BEQ remain_r7_2
	cmp r7,#0
	BEQ remain_r6_2
	ldr r8,[r3]
	ldr r9,[r4]
	BL cmp_sign
	STR r13,[r5],#4
	SUB R1,#1	
	B ms_arr2_to_arr1_re
	
remain_sorted ; sort remain sub arr
	cmp r1,r2
	SUBPL r7,r1,r2
	MOVMI r6,r1
	MOVMI r7,#0
	BX LR

remain_r6 ;sub arr remain at arr1
	cmp r6,#0
	MOVEQ r3,r4
	BEQ ms_arr1_to_arr2_set
	LDR r8,[r3],#4
	STR r8,[r5],#4
	SUB r6,#1
	SUB R1,#1
	B remain_r6
remain_r7 ;sub arr remain at arr1
	cmp r7,#0
	MOVEQ r3,r4
	BEQ ms_arr1_to_arr2_set
	LDR r8,[r4],#4
	STR r8,[r5],#4
	SUB r7,#1
	SUB R1,#1
	B remain_r7
remain_r6_2 ;sub arr remain at arr2
	cmp r6,#0
	MOVEQ r3,r4
	BEQ ms_arr2_to_arr1_set
	LDR r8,[r3],#4
	STR r8,[r5],#4
	SUB r6,#1
	SUB R1,#1
	B remain_r6_2
remain_r7_2;sub arr remain at arr2
	cmp r7,#0
	MOVEQ r3,r4
	BEQ ms_arr2_to_arr1_set
	LDR r8,[r4],#4
	STR r8,[r5],#4
	SUB r7,#1
	SUB R1,#1
	B remain_r7_2
	
	
;DATA COMPARE	
cmp_sign ; compare sign bit
	LSR r10,r8,#31
	LSR r11,r9,#31
	cmp r10,r11
	MOVMI r13,r9
	SUBMI r7,#1
	ADDMI r4,#4
	BEQ cmp_ex
	MOVPL r13,r8
	SUBPL r6,#1
	ADDPL r3,#4
	BX LR
cmp_ex ; compare others

	cmp r10,#1
	BEQ cmp_ex_neg
	LSL r10,r8,#1
	LSL r11,r9,#1
	LSR r10,r10,#1
	LSR r11,r11,#1
	cmp r10,r11
	MOVMI r13,r8
	SUBMI r6,#1
	ADDMI r3,#4
	MOVPL r13,r9
	SUBPL r7,#1
	ADDPL r4,#4
	BX LR
	
cmp_ex_neg	; compare sign bit when sign is 1
	LSL r10,r8,#1
	LSL r11,r9,#1
	LSR r10,r10,#1
	LSR r11,r11,#1
	cmp r10,r11
	MOVPL r13,r8
	SUBPL r6,#1
	ADDPL r3,#4	
	MOVMI r13,r9
	SUBMI r7,#1
	ADDMI r4,#4	
	BX LR
	
;==============================================	

load ; mov data  arr to final arr
	LDR r4,[r3],#4
	SWP r4,r4,[r0]
	ADD r0,r0,#4
	SUB r1,#1
	CMP r1,#0
	BNE load
	
exit ; end

	MOV pc, #0 ;Program end
	END

;========== End your code here ===========