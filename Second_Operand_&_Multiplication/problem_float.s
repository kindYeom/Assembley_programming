   AREA ARMex, CODE, READONLY
      ENTRY

start
   mov r12,#1
   ldr r1,floating1; data 1
   ldr r2,floating2;data 2

   
   LDR r1,[r1]; to use memory save float number 4268 58D
   LDR r2,[r2]; to use memory save float number 4228 42D
   
   mov r3,r1,LSR#31 ;sign
   mov r4,r1,LSL#1;
   
   mov r4,r4,LSR#24;Exponent
   mov r5,r1,LSL#9
   mov r5,r5,LSR#9;Mantissa   
   add r5,r12,LSL#23

    
   mov r6,r2,LSR#31;sign
   mov r7,r2,LSL#1
   mov r7,r7,LSR#24;Exponent
   mov r8,r2,LSL#9
   mov r8,r8,LSR#9;Mantissa
   add r8,r12,LSL#23
   
   cmp r3,r6
   BEQ adder
   BNE subber
   
adder   
   cmp r4,r7; compare EX
   mov r1,r3; sign upload

   SUBPL r9,r4,r7; shift num
   
   SUBMI r9,r7,r4; shift num 
   
   MOVPL r8,r8,LSR r9
   MOVPL r7,r4 ;make EX epual
   MOVMI r5,r5,LSR r9
   MOVMI r4,r7 ; make EX epual
   
   add r10,r8,r5  ;; complete
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   mov r11,#8 ; ex basic
   mov r12,r10 ; find 1
   BL loop1

   
   mov r3,r10,LSR r11 ; to mov sign local
   mov r12,#1
   sub r3,r3,r12,LSL#23 // remove 1
      
   add r2,r7,r11 // add EX

   mov r0,r1,LSL#31 // msb
   add r0,r0,r2,LSL#23// ex
   add r0,r0,r3 // sign


   B EXIT
   
subber
   cmp r4,r7; compare EX
   
   SUBPL r9,r4,r7; shift num

   SUBMI r9,r7,r4; shift num
  
   MOVPL r8,r8,LSR r9
   MOVPL r7,r4 ;make EX epual
   MOVMI r5,r5,LSR r9
   MOVMI r4,r7 ; make EX epual
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   
   CMPEQ r5,r8 ; if ex is equal then compare mantisa
   
   MOVPL r1,r3 // sign bit made
   MOVMI r1,r6;; sign bit made 

   SUBPL r10,r5,r8 // if r5>r8
   SUBMI r10,r8,r5//if r8>r5
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ok
   mov r11,#0
   mov r12,r10
   BL loop2
   sub r11,r11,#8 // ex
   
   mov r3,r10,LSL r11 // sign local
   mov r12,#1
   sub r3,r3,r12,LSL#23 // remove 1
      
   sub r2,r7,r11 // ex
   
   mov r0,r1,LSL#31 // msb
   add r0,r0,r2,LSL#23// ex
   add r0,r0,r3 // sign
   B EXIT
   
   
loop1
   cmp r12,#0 ; when msb = 1 end
   SUBPL R11,#1    // to find ex
   MOVPL r12,r12,LSL#1 // lsl1
   BPL loop1
   BX LR
   
loop2
   cmp r12,#0; when msb = 1 end
   ADDPL R11,#1    // to find ex
   MOVPL r12,r12,LSL#1// LSL1
   BPL loop2
   BX LR
   
floating1 & &40000400
floating2 & &40000404
save_result & &40000000
EXIT
	LDR r10,save_result
	str r0,[r10]

   end
   