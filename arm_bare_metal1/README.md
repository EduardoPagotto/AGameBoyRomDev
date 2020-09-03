# Arm Bare Metal
Test ARM Code 

## Instalação
Cross-Compiller ToolChain: https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads
```bash
tar xvf gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2
mv gcc-arm-none-eabi-9-2020-q2-update /opt/
```

Dependencias Ubuntu 20.04
```bash
#gdb
sudo apt install libncurses5
sudo apt install libncurses5-dev

#qemu
sudo apt install qemu-system-arm
```

## Compilar
```bash
arm-none-eabi-as -mcpu=arm926ej-s -g startup.s -o startup.o
arm-none-eabi-gcc -c -mcpu=arm926ej-s -g test.c -o test.o
arm-none-eabi-ld -T test.ld test.o startup.o -o test.elf
arm-none-eabi-objcopy -O binary test.elf test.bin
```

## Testar
```bash
qemu-system-arm -M versatilepb -m 128M -nographic -kernel test.bin
qemu-system-arm -M versatilepb -m 128M -nographic -s -S -kernel test.bin
```

## GDB
target remote localhost:1234
file test.elf

## Refs:
- https://balau82.wordpress.com/2010/02/28/hello-world-for-bare-metal-arm-using-qemu/


## CMAKE
cmake ../ -DCMAKE_TOOLCHAIN_FILE:FILE_PATH=../toolchain.cmake