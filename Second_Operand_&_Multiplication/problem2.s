 AREA ARMex, CODE, READONLY
      ENTRY

start
   LDR r1,save_result
	mov r3,#1  ; 1

   mov r2,#1 ; 1
   STR r2,[r1],#4
   
   add r3,r3,#1 ; 2
   MUL r2,r3,r2 ; r2 *2
   STR r2,[r1],#4 
   
   add r3,r3,#1 ; 3
   MUL r2,r3,r2 ; r2 *3
   STR r2,[r1],#4
   
   add r3,r3,#1 ;4
   MUL r2,r3,r2 ; r2 * 4
   STR  r2,[r1],#4
   

   add r3,r3,#1 ; 5
   MUL r2,r3,r2 ; r2 * 5
   STR r2,[r1],#4
   
   add r3,r3,#1 ; 6
   MUL r2,r3,r2 ; r2 * 6
   STR r2,[r1],#4
   
   add r3,r3,#1 ; 7
   MUL r2,r3,r2 ; r2 * 7
   STR r2,[r1],#4
   
   add r3,r3,#1 ; r2
   MUL r2,r3,r2 ; r2 * 8
   STR r2,[r1],#4
      
   add r3,r3,#1; 10
   MUL r2,r3,r2 ; r2 * 9
   STR r2,[r1],#4
   
   add r3,r3,#1; 10
   MUL r2,r3,r2     ;r2 * 10
   STR r2,[r1],#4
   

save_result & &40000000


   end