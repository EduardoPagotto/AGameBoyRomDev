TOOLCHAIN = /opt/gcc-arm-none-eabi-9-2020-q2-update
CC := $(TOOLCHAIN)/bin/arm-none-eabi-gcc
AS := $(TOOLCHAIN)/bin/arm-none-eabi-as
OBJCOPY := $(TOOLCHAIN)/bin/arm-none-eabi-objcopy
INC = $(TOOLCHAIN)/arm-none-eabi/include

obj := crt0.o example.o
bin := example.gba
opt := -O3 -fomit-frame-pointer -marm -mcpu=arm7tdmi
#opt := -O3 -fomit-frame-pointer -marm -mcpu=arm7tdmi -specs=nano.specs -specs=nosys.specs
CFLAGS =  $(opt) -std=c99 -O3 -pedantic -Wall -nostartfiles -lm -lc

$(bin): $(obj)
	$(CC) -o out.elf -I$(INC) $(obj) -Tlnkscript -nostartfiles -lm
	$(OBJCOPY) -O binary out.elf $(bin)
	$(RM) out.elf

-include $(obj:.o=.d)

%.d: %.c
	@rm -f $@; $(CC) -MM $(CFLAGS) $< > $@

.PHONY: clean
clean:
	rm -f $(obj) $(obj:.o=.d) $(bin)
