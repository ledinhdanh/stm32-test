/* This will work with STM32 type of microcontrollers.    *
 * The sizes of RAM and flash are specified smaller than  *
 * what most of the STM32 provide to ensure that the demo *
 * program will run on ANY STM32.                         */
MEMORY
{
    ram (rwx) : ORIGIN = 0x20000000, LENGTH = 8K
    rom (rx)  : ORIGIN = 0x08000000, LENGTH = 128K
}

SECTIONS
{
    .text :
    {
	__rom_start__ = .;
        *(vectors)    /* Vector table */
        *(.text)      /* Program code */
        *(.rodata)    /* Read only data */
	. = ALIGN(4);
	__rom_end__ = .;
    } >rom

    .data :
    {
        __data_start__ = .;
        *(.data)      /* Data memory */
        __data_end__ = .;
    } >ram AT >rom

    .bss :
    {
        __bss_start__ = .;
        *(.bss)       /* Zero-filled run time allocate data memory */
        __bss_end__ = .;
    } >ram AT >rom
}

__data_size__ = __data_end__ - __data_start__;
__bss_size__ = __bss_end__ - __bss_start__;
