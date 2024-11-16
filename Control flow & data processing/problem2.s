	AREA ARMex,CODE,READONLY  
	ENTRY                   
start                   
	LDR r4, TEMPADDR1
	LDR r0, =string
	MOV R1, #0
    BL strlen ; Return after loop operation
	str R1,[r4]
	B EXIT
strlen
	LDRB R2, [R0], #1 
	CMP R2, #0 ; Compare if the string is zero
	ADDNE R1, R1, #1 ; Add if the character is non-zero
	BNE strlen; Loop Repeat
	BX LR	
EXIT	

TEMPADDR1 & &00040000
string DCB "HELLO",0 ;Save string in strlen

END
	end
