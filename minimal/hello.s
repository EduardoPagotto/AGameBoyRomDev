.thumb
.section .Vectors
.word __stack @ setup the stack using result of memmap.ld
.word _start  @ Entry point
.word _nmi    @ NMI
.word _fault  @ Exception fault
.word 0       @ Not used
.word 0       @ ...
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
var1: .word 0xFF  /* variable 1 in memory */
var2: .word 0xCC  /* variable 2 in memory */

.text          /* start of the text (code) section */
.thumb_func     @ all thumb funcion MUST THIS!!!!(increase 1 to address call)
_nmi:
    movs r0, #1
    movs r1, #2
    bkpt

.thumb_func
_fault:
    movs r0, #3
    movs r1, #4

.thumb_func
_deadCode:
    movs r2, #5
    movs r3, #6
    bkpt 

.thumb_func
_start:
    movs r0, #1
    movs r1, #2
    movs r2, #3
    ldr r0, adr_var1  @ load the memory address of var1 via label adr_var1 into R0 
    ldr r1, adr_var2  @ load the memory address of var2 via label adr_var2 into R1 
    ldr r2, [r0]      @ load the value (0x03) at memory address found in R0 to register R2  
    str r2, [r1]      @ store the value found in R2 (0x03) to the memory address found in R1 
    b _deadCode  
           
.align 2
@ .section .rodata
adr_var1: .word var1  /* address to var1 stored here */
adr_var2: .word var2  /* address to var2 stored here */
.end
