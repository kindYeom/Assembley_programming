	AREA ARMex,CODE,READONLY  
	ENTRY                   
start     
	LDR r4, TEMPADDR1
	MOV r0, #10
	add r1,r0,#1
	mul r0,r1,r0
	LSR r0,r0,#1  ; divide r0,2 
	
	
	str r0,[r4]
TEMPADDR1 & &00040000
END
	end
