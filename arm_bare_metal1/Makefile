TOOLCHAIN = /opt/gcc-arm-none-eabi-9-2020-q2-update
CC := $(TOOLCHAIN)/bin/arm-none-eabi-gcc
AS := $(TOOLCHAIN)/bin/arm-none-eabi-as
LD := $(TOOLCHAIN)/bin/arm-none-eabi-ld 
OBJCOPY := $(TOOLCHAIN)/bin/arm-none-eabi-objcopy
LDSCRIPT := test.ld
#bin := test.bin

opt := -mcpu=arm926ej-s -g
CFLAGS =  $(opt) -marm -std=c99 -O3 -pedantic -Wall -nostartfiles -lm -lc

all: startup.o test.o
	$(LD) -T $(LDSCRIPT) test.o startup.o -o test.elf
	$(OBJCOPY) -O binary test.elf test.bin

startup.o : startup.s 
	$(AS) $(opt) startup.s -o startup.o

test.o : test.c
	$(CC) -c $(CFLAGS)  test.c -o test.o

.PHONY: clean
clean:
	rm -f *.o *.elf *.bin