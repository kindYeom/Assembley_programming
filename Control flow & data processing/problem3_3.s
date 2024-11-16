	AREA ARMex,CODE,READONLY  
	ENTRY                   
start                   
	LDR r4, TEMPADDR1
	add r0,r0,#1
	add r0,r0,#2
	add r0,r0,#3
	add r0,r0,#4
	add r0,r0,#5
	add r0,r0,#6
	add r0,r0,#7
	add r0,r0,#8
	add r0,r0,#9
	add r0,r0,#10
	
		str r0,[r4]
TEMPADDR1 & &00040000
END
	end
