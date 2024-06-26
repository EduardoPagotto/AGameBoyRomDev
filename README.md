# AGameBoyRomDev
Test ARM Code Game Boy Advanced and Bare Metal ARM in qemu to test

## Instalation
Cross-Compiller ToolChain: https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads
```bash
tar xvf gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2
mv gcc-arm-none-eabi-9-2020-q2-update /opt/
```

Dependencies Ubuntu 20.04
```bash
# gdb
sudo apt install libncurses5
sudo apt install libncurses5-dev

# QEMU
sudo apt install qemu-system-arm

# App de execução de ROM AGB
apt-get install visualboyadvance
```

VSCode
ext install webfreak.debug

## Compilar
MakeFile
```bash
make
```
or
```bash
# set correct path to /opt/ before
arm-none-eabi-as -mcpu=arm926ej-s -g startup.s -o startup.o
arm-none-eabi-gcc -c -mcpu=arm926ej-s -g test.c -o test.o
arm-none-eabi-ld -T test.ld test.o startup.o -o test.elf
arm-none-eabi-objcopy -O binary test.elf test.bin
```

## Tests

# AGB Rom
```bash
vba example.gba 
```

# arm_base_metal1
```bash
# run direct
# qemu-system-arm -M versatilepb -m 128M -nographic -kernel test.bin

# run and wait gdb
qemu-system-arm -M versatilepb -m 128M -nographic -s -S -kernel test.bin
```
```GDB
target remote localhost:1234
file hello.elf

br _start
info regi
disas _start

run
nexti 1
```

# Test minimal project
```bash
# Start qemu-arm
qemu-system-arm -M microbit -device loader,file=hello.hex -S -s -singlestep -m 512 &

# Start GDB
/opt/gcc-arm-none-eabi-10-2020-q4-major/bin/arm-none-eabi-gdb
```

```GDB
(gdb) target remote localhost:1234
(gdb) file hello.elf
(gdb) br _start
(gdb) info regi
(gdb) disas _start
(gdb) stepi

```

## Refs
AGB
- https://github.com/138paulmiller/GBAk.git
- https://docs.rtems.org/releases/rtemsdoc-4.7.3/share/rtems/html/bsp_howto/bsp_howto00021.html
- http://www.science.smith.edu/dftwiki/index.php/CSC231_Makefile_for_linking_ASM_and_C_Files

QEMU:
- https://balau82.wordpress.com/2010/02/28/hello-world-for-bare-metal-arm-using-qemu/


## CMAKE
obs: diretorio cmake_test tem um teste de uso do CMake para compilar, atualmente falha no link

cmake ../ -DCMAKE_TOOLCHAIN_FILE:FILE_PATH=../toolchain.cmake