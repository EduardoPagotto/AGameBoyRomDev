#https://stackoverflow.com/questions/39842618/compile-arm-binaries-run-them-in-armulator

#ARMGNU ?= arm-none-linux-gnueabi
ARMGNU ?= /opt/gcc-arm-none-eabi-10-2020-q4-major/bin/arm-none-eabi
#ARMGNU ?= arm-linux-gnueabi
COPS = -Wall -O2 -nostdlib -nostartfiles -ffreestanding 


all : hello.bin

clean :
    rm -f *.o
    rm -f *.bin
    rm -f *.elf
    rm -f *.list
    rm -f *.srec
    rm -f *.hex

hello.o : hello.s
    $(ARMGNU)-as hello.s -o hello.o


hello.bin : hello.o memmap
    $(ARMGNU)-ld -T memmap hello.o -o hello.elf
    $(ARMGNU)-objdump -D hello.elf > hello.list
    $(ARMGNU)-objcopy hello.elf -O ihex hello.hex
    $(ARMGNU)-objcopy hello.elf -O srec hello.srec 
    $(ARMGNU)-objcopy hello.elf -O binary hello.bin 
    $(ARMGNU)-objdump -d hello.o -l > diss.s