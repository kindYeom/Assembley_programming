 AREA ARMex, CODE, READONLY
      ENTRY

start
	ldr r0,save_result
   mov r1,#17
   mov r2,#3
   
   
   mul r4,r2,r1 ; 3 *17
   str r4,[r0]

save_result & &40000000


   end