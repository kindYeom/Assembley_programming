	AREA ARMex, CODE, READONLY
		ENTRY

start
	LDR r4, TEMPADDR1
	mov r0, #5 ; a
	mov r1, #4 ; b
	mov r2, #3 ; c
	mov r3, #2 ; d

	sub r5,r0,r1	; r5 = a -  b
	mul r6,r3,r3	; r6 = d * 2 
	add r6,r6,r2	; R6 = c+ (d * 2)
	add r7,r5,r6	; R7 = (a-b) + (c+(d*2))
	
	str r7,[r4]
TEMPADDR1 & &00040000

END
		end
