# Configuring

FLAGS= --32 --gstabs+
AS= as
LD= ld
LDFLAGS= -m elf_i386

# Sources

SRCS:= 	sources/main.s \
       	sources/user_mode.s \
	sources/superuser_mode.s \
	sources/print_string_error.s \
       	sources/menu.s \
       	sources/scelta_lockdoor.s \
       	sources/scelta_backhome.s \
	sources/scelta_frecce_direzione.s \
	sources/reset_pressione.s \
       	sources/itoa.s \
       	sources/atoi.s \
	sources/atoi_read.s \
	sources/printf.s \
       	sources/new_l.s \
       	sources/end.s \
 	sources/compare_key.s

# Objects

OBJS:= $(SRCS:.s=.o)

# Default target

all: run.x

# Compiling

main.o: sources/main.s
	@echo $@
	$(AS) $(FLAGS) $^ -o $@

user_mode.o: sources/user_mode.s
	@echo $@
	$(AS) $(FLAGS) $^ -o $@

superuser_mode.o: sources/superuser_mode.s
	@echo $@
	$(AS) $(FLAGS) $^ -o $@

print_string_error.o: sources/print_string_error.s
	@echo $@
	$(AS) $(FLAGS) $^ -o $@

menu.o: sources/menu.s
	@echo $@
	$(AS) $(FLAGS) $^ -o $@

scelta_lockdoor.o: sources/scelta_lockdoor.s
	@echo $@
	$(AS) $(FLAGS) $^ -o $@

scelta_backhome.o: sources/scelta_backhome.s
	@echo $@
	$(AS) $(FLAGS) $^ -o $@

scelta_frecce_direzione.o: sources/scelta_frecce_direzione.s
	@echo $@
	$(AS) $(FLAGS) $^ -o $@

reset_pressione.o: sources/reset_pressione.s
	@echo $@
	$(AS) $(FLAGS) $^ -o $@

itoa.o: sources/itoa.s
	@echo $@
	$(AS) $(FLAGS) $^ -o $@

atoi.o: sources/atoi.s
	@echo $@
	$(AS) $(FLAGS) $^ -o $@

atoi_read.o: sources/atoi_read.s
	@echo $@
	$(AS) $(FLAGS) $^ -o $@

printf.o: sources/printf.s
	@echo $@
	$(AS) $(FLAGS) $^ -o $@

new_l.o: sources/new_l.s
	@echo $@
	$(AS) $(FLAGS) $^ -o $@

end.o: sources/end.s
	@echo $@
	$(AS) $(FLAGS) $^ -o $@

compare_key.o: sources/compare_key.s
	@echo $@
	$(AS) $(FLAGS) $^ -o $@


run.x: 	\
	main.o \
    	user_mode.o \
	superuser_mode.o \
	print_string_error.o \
    	menu.o \
    	scelta_lockdoor.o \
    	scelta_backhome.o \
	scelta_frecce_direzione.o \
	reset_pressione.o \
    	itoa.o \
    	atoi.o \
	atoi_read.o \
	printf.o \
    	new_l.o \
    	end.o \
    	compare_key.o \

	@echo LINKED: $@
	$(LD) $(LDFLAGS) $^ -o $@

# Removing objects

clean:
	@rm *.o
	@echo "Cleaning"

.PHONY: all clean
