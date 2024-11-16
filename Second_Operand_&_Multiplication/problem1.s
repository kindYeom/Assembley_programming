	AREA ARMex, CODE, READONLY
		ENTRY

start
	LDR r1,save_result


	mov r0,#0
	mov r2,#1
	STR r2,[r1],#4 ; 1
	
	add r2,r2,r2 ; 1 * 2
	STR r2,[r1],#4
	
	mov r3,r2
	add r2,r3,r2,LSL#1 ;r2 * 2 r2
	STR	r2,[r1],#4
	
	add r2,r0,r2,LSL#2;	r2 * 4
	STR	r2,[r1],#4
	
	mov r3,r2 
	add r2,r2,r3,LSL#2 ; r2 * 4 + r2
	STR r2,[r1],#4
	
	mov r3,r2,LSL#1
	add r2,r3,r2,LSL#2 ;r2 * 4 + r2 *2
	STR r2,[r1],#4
	
	mov r3,r2
	add r2,r0,r2,LSL#2; r2 * 4
	add r2,r2,r3,LSL#1 ; r2 *2
	add r2,r2,r3; r2* 4 + r2 * 2 + r2
	STR r2,[r1],#4
	
	mov r2,r2,LSL#3 ;r2 * 8
	STR r2,[r1],#4
		
	mov r3,r2
	add r2,r2,r3,LSL#3 ;r2 * 8 + r2 
	STR r2,[r1],#4
		
	mov r3,r2,LSL#1 ; r2 * 2
	add r2,r3,r2,LSL#3 ; r2 * 8 + r2 * 2

	STR r2,[r1],#4
	

save_result & &40000000


	end
	