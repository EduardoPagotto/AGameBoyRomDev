PRESERVE8
THUMB

AREA RESET, DATA, READONLY
EXPORT __Vectors

__Vectors   DCD 0X000003FC
            DCD Reset_Handler
            DCD 0
            DCD 0
            DCD 0
            DCD 0
            DCD 0
            DCD 0
            DCD 0
            DCD 0
            DCD 0
            DCD 0
            DCD 0
            DCD 0
            DCD 0
            DCD 0

            ; external interrupt

            DCD 0
            DCD 0
            DCD 0
            DCD 0
            DCD 0
            DCD 0
            DCD 0
            DCD 0
            DCD 0
            DCD 0
            DCD 0
            DCD 0
            DCD 0
            DCD 0
            DCD 0
            DCD 0
            DCD 0

            AREA | .text|, CODE, READONLY
Reset_Handler   PROC
                GLOBAL Reset_Handler
                ENTRY
AGAIN           LDR R1, =0X50000000
                LDR R0, =0X55
                STR R0,[R1]

                LDR R1, =0X50000000
                LDR R0,=0XAA
                STR RO,[R1]

                B AGAIN
                ENDP

                ALIGN 4
