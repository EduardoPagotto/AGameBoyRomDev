MEMORY
{
    FLASH (rx)  : ORIGIN = 0x00000000, LENGTH = 0x400
    RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 0x400
}

OUTPUT_FORMAT ("elf32-littlearm", "elf32-bigarm", "elf32-littlearm")

SECTIONS
{
    .text :
    { 
        KEEP(*(.Vectors))
        *(.text*)
        *(.rodata*)
        . = ALIGN(4);
    } > FLASH

    .data :
    { 
		__data_start__ = .;
		*(.data*)
        . = ALIGN(4);
		__data_end__ = .;
    } > RAM

    .bss :
	{
        . = ALIGN(4);
		__bss_start__ = .;
		*(.bss*)
		*(COMMON)
        . = ALIGN(4);
		__bss_end__ = .;
	} > RAM

	.heap (COPY):
	{
		__end__ = .;
		end = __end__;
		*(.heap*)
		__HeapLimit = .;
	} > RAM

	.stack_dummy (COPY):
	{
		*(.stack*)
	} > RAM

	__StackTop = ORIGIN(RAM) + LENGTH(RAM);
	__StackLimit = __StackTop - SIZEOF(.stack_dummy);
	PROVIDE(__stack = __StackTop);

	/* Check if data + heap + stack exceeds RAM limit */
	ASSERT(__StackLimit >= __HeapLimit, "region RAM overflowed with stack")
}