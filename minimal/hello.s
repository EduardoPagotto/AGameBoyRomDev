.thumb
.section .Vectors
.word __stack
.word _start
.word _nmi
.word _fault
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0

.data
var1: .word 0x01  /* variable 1 in memory */
var2: .word 0x02  /* variable 2 in memory */

.text          /* start of the text (code) section */
_nmi:
    movs r0, #1
    movs r1, #2
    bkpt
_fault:
    movs r0, #3
    movs r1, #4
_dead:
    movs r2, #5
    movs r3, #6
    bkpt 
_start:
    movs r0, #1
    movs r1, #2
    movs r2, #3
    ldr r0, adr_var1  @ load the memory address of var1 via label adr_var1 into R0 
    ldr r1, adr_var2  @ load the memory address of var2 via label adr_var2 into R1 
    ldr r2, [r0]      @ load the value (0x03) at memory address found in R0 to register R2  
    str r2, [r1]      @ store the value found in R2 (0x03) to the memory address found in R1 
    bkpt             
.align 2
@ .section .rodata
adr_var1: .word var1  /* address to var1 stored here */
adr_var2: .word var2  /* address to var2 stored here */
.end
