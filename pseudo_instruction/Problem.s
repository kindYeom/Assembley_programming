	AREA ARMex, CODE, READONLY
		ENTRY

start
	LDR r1, =Arr1 ; array 1
	LDR r2, =Arr2 ; array 2
	LDR r5, =K ; length of array2
	mov r4,#0	; reg of 

	
	BL LOOP; ; loop for cpoy
	
	STR r4,[r5] ; store length


	BX lr
	
LOOP 
    LDRB r3, [r1], #1 ; store r3->r1
    CMP r3, #0x0A; if it is end of line
    BEQ ENDLOOP ; endloop
    CMP r3, #0x20 ; if it is "space"
    STRNEB r3, [r2], #1 ; no copy
	ADDNE r4,r4,#1 ; add k 
    B LOOP ;; loop again
ENDLOOP
	BX lr	

	
	AREA dataArray,DATA
K ; length of array
	DCB 0
Arr1 DCB "Hello World",'\n' ; first string
	ALIGN
Arr2
	DCB 0 ; string copied

	end
