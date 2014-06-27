# Configuring

FLAGS= --32 --gstabs+
AS= as
LD= ld
LDFLAGS= -m elf_i386

# Sources

SRCS:= sources/main.s \
       sources/user_mode.s \
	   sources/supervisor_mode.s \
	   sources/print_msg_error.s \
       sources/print_menu_voice.s \
       sources/print_menu_lock_door.s \
       sources/print_menu_back_home.s \
	   sources/print_menu_direction_arrows.s \
	   sources/print_menu_reset_tire_pressure.s \
       sources/itoa.s \
       sources/atoi.s \
	   sources/atoi_read.s \
	   sources/print.s \
       sources/new_line.s \
       sources/end.s

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

supervisor_mode.o: sources/supervisor_mode.s
	@echo $@
	$(AS) $(FLAGS) $^ -o $@

print_msg_error.o: sources/print_msg_error.s
	@echo $@
	$(AS) $(FLAGS) $^ -o $@

print_menu_voice.o: sources/print_menu_voice.s
	@echo $@
	$(AS) $(FLAGS) $^ -o $@

print_menu_lock_door.o: sources/print_menu_lock_door.s
	@echo $@
	$(AS) $(FLAGS) $^ -o $@

print_menu_back_home.o: sources/print_menu_back_home.s
	@echo $@
	$(AS) $(FLAGS) $^ -o $@

print_menu_direction_arrows.o: sources/print_menu_direction_arrows.s
	@echo $@
	$(AS) $(FLAGS) $^ -o $@

print_menu_reset_tire_pressure.o: sources/print_menu_reset_tire_pressure.s
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

print.o: sources/print.s
	@echo $@
	$(AS) $(FLAGS) $^ -o $@

new_line.o: sources/new_line.s
	@echo $@
	$(AS) $(FLAGS) $^ -o $@

end.o: sources/end.s
	@echo $@
	$(AS) $(FLAGS) $^ -o $@

run.x: \
	main.o \
    user_mode.o \
	supervisor_mode.o \
	print_msg_error.o \
    print_menu_voice.o \
    print_menu_lock_door.o \
    print_menu_back_home.o \
	print_menu_direction_arrows.o \
	print_menu_reset_tire_pressure.o \
    itoa.o \
    atoi.o \
	atoi_read.o \
	print.o \
    new_line.o \
    end.o
	@echo LINKED: $@
	$(LD) $(LDFLAGS) $^ -o $@

# Removing objects

clean:
	@rm *.o
	@echo "Cleaning"

.PHONY: all clean
