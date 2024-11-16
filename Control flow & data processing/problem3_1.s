	AREA ARMex,CODE,READONLY  
	ENTRY                   
start             
	LDR r4, TEMPADDR1
	MOV r0, #0
	MOV r1, #1
    BL for_loop ; Return after loop operation
	B done
	
for_loop
	cmp r1, #11
	BEQ done
	ADD r0,r1,r0
	ADD r1,r1,#1
	B for_loop
done
	str r0,[r4]
TEMPADDR1 & &00040000

END
	end