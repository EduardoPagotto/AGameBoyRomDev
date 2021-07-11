.globl _start
_start:
    b reset
    b hang
    b hang
    b hang
    b hang
    b hang
    b hang
    b hang

hang: b hang

reset:
    mov r0,#0x16000000
    mov r1,#0x55
    str r1,[r0]
    add r1,r1,#1
    str r1,[r0]
    mov r0,#0xF0000000
    str r1,[r0]
    b hang