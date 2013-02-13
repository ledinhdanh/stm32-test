# Makefile for the template/example projects in the STM32L1 StdPeriph Driver
# package.
#
# It uses GCC and OpenOCD (or stlink, see bottom of file).
#
# Like the readme.txt file in each example directory says (in STM32 StdPeriph
# Driver library), copy the example contents over to the project template
# directory and build.
#
# Tested with Mentor Sourcery ARM GCC toolchain.

# Basename for the resulting .elf/.bin/.hex file
RESULT ?= main

# Path to the STM32L1xx_StdPeriph_Lib_V1.0.0/ directory
TOPDIR = .

# NOTE: The STM32L1 stdperiph package lacks the syscalls.c file that the
# STM32F0 package has.
SOURCES = \
	  $(TOPDIR)/Project/STM32L1xx_StdPeriph_Templates/main.c \
	  $(TOPDIR)/Project/STM32L1xx_StdPeriph_Templates/stm32l1xx_it.c \
	  $(TOPDIR)/Project/STM32L1xx_StdPeriph_Templates/system_stm32l1xx.c \
	  $(TOPDIR)/Libraries/CMSIS/Device/ST/STM32L1xx/Source/Templates/TrueSTUDIO/startup_stm32l1xx_md.s \
	  $(wildcard $(TOPDIR)/Libraries/STM32L1xx_StdPeriph_Driver/src/*.c) \
	  $(TOPDIR)/Utilities/STM32_EVAL/STM32L152_EVAL/stm32l152_eval.c \
	  $(TOPDIR)/Utilities/STM32_EVAL/STM32L152_EVAL/stm32l152_eval_lcd.c \
	  $(TOPDIR)/syscalls.c \
	  $(TOPDIR)/baselibc_stdio.c \

HEADERS = \
	  $(TOPDIR)/Project/STM32L1xx_StdPeriph_Templates/main.h \
	  $(TOPDIR)/Project/STM32L1xx_StdPeriph_Templates/stm32l1xx_conf.h \
	  $(TOPDIR)/Project/STM32L1xx_StdPeriph_Templates/stm32l1xx_it.h \
	  $(TOPDIR)/Utilities/STM32_EVAL/STM32L152_EVAL/stm32l152_eval.h \
	  $(wildcard $(TOPDIR)/Libraries/CMSIS/Include/*.h) \
	  $(wildcard $(TOPDIR)/Libraries/CMSIS/Device/ST/STM32L1xx/Include/*.h) \
	  $(wildcard $(TOPDIR)/Libraries/STM32L1xx_StdPeriph_Driver/inc/*.h)

LINKER_SCRIPT = $(TOPDIR)/Project/STM32L1xx_StdPeriph_Templates/TrueSTUDIO/STM32L152-EVAL/STM32_flash.ld

INCLUDES += -I$(TOPDIR)/Libraries/CMSIS/Device/ST/STM32L1xx/Include \
	    -I$(TOPDIR)/Libraries/CMSIS/Include \
	    -I$(TOPDIR)/Libraries/STM32L1xx_StdPeriph_Driver/inc \
	    -I$(TOPDIR)/Utilities/STM32_EVAL/STM32L152_EVAL \
	    -I$(TOPDIR)/Utilities/STM32_EVAL/Common \
	    -I$(TOPDIR)/Project/STM32L1xx_StdPeriph_Templates

CFLAGS += -DUSE_STDPERIPH_DRIVER -fno-common -Wall -Os -g3 -mcpu=cortex-m3 -mthumb
CFLAGS += -ffunction-sections -fdata-sections -Wl,--gc-sections
CFLAGS += $(INCLUDES)
CFLAGS += -DUSE_STM32L152_EVAL
CFLAGS += -IBaselibc/include

CROSS_COMPILE ?= arm-none-eabi-
CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)ld
OBJDUMP = $(CROSS_COMPILE)objdump
OBJCOPY = $(CROSS_COMPILE)objcopy
SIZE = $(CROSS_COMPILE)size


# So that the "build depends on the makefile" trick works no matter the name of
# the makefile
THIS_MAKEFILE := $(lastword $(MAKEFILE_LIST))

all: build size

build: $(RESULT).elf $(RESULT).bin $(RESULT).hex $(RESULT).lst

Baselibc/libc.a: $(THIS_MAKEFILE)
	$(MAKE) -C Baselibc PLATFORM=cortex-m3

$(RESULT).elf: Baselibc/libc.a $(SOURCES) $(HEADERS) $(LINKER_SCRIPT) $(THIS_MAKEFILE)
	$(CC) -Wl,-M=$(RESULT).map -Wl,-T$(LINKER_SCRIPT) $(CFLAGS) $(SOURCES) Baselibc/libc.a -o $@

%.hex: %.elf
	$(OBJCOPY) -O ihex $< $@

%.bin: %.elf
	$(OBJCOPY) -O binary $< $@

%.lst: %.elf
	$(OBJDUMP) -x -S $(RESULT).elf > $@

size: $(RESULT).elf
	$(SIZE) $(RESULT).elf

install: build
	st-flash write $(RESULT).bin 0x08000000
## Or with openocd (>= v0.6.0)
#openocd -f board/stm32f0discovery.cfg -c "init; reset halt; flash write_image erase $(RESULT).bin 0x08000000; reset run; shutdown"

clean:
	rm -f $(RESULT).elf
	rm -f $(RESULT).bin
	rm -f $(RESULT).map
	rm -f $(RESULT).hex
	rm -f $(RESULT).lst
	$(MAKE) -C Baselibc clean

.PHONY: all build size clean install
