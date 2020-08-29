# AGameBoyRomDev
Test ARM Code 

## Instalação o Cross-Compiller ToolChain
Download do site: https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads

```bash
tar xvf gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2
mv gcc-arm-none-eabi-9-2020-q2-update /opt/
```

## Instalação do App de execução de ROM
```bash
apt-get install visualboyadvance
```

## Compilar
```bash
make
```

## Testar
```bash
vba example.gba 
```

## Refs:
- https://github.com/138paulmiller/GBAk.git
