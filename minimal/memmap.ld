MEMORY
{
    FLASH (rx)  : ORIGIN = 0x00000000, LENGTH = 0x1000
    RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 0x1000
    
}

OUTPUT_FORMAT ("elf32-littlearm", "elf32-bigarm", "elf32-littlearm")

SECTIONS
{
    .text : 
    { 
        *(.text*) 
        *(.rodata*) 
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
}