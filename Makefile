# Project name
PROJECT = battleBot

# Hardware target (LAUNCHPAD or battleBot)
HW ?= LAUNCHPAD

# Paths
SRC_DIR = src
BUILD_DIR = build

# Compiler and flags
CC = msp430-elf-gcc
OBJCOPY = msp430-elf-objcopy
SIZE = msp430-elf-size

# MCU settings
MCU = msp430g2553

# Compiler flags
CFLAGS = -mmcu=$(MCU)
CFLAGS += -O2
CFLAGS += -Wall -Wextra
CFLAGS += -D$(HW)

# Linker flags
LDFLAGS = -mmcu=$(MCU)
LDFLAGS += -L"C:/ti/msp430-gcc/include"

# Include paths
INCLUDES = -I$(SRC_DIR)
INCLUDES += -I$(SRC_DIR)/app
INCLUDES += -I$(SRC_DIR)/common
INCLUDES += -I$(SRC_DIR)/drivers
INCLUDES += -IC:/ti/msp430-gcc/include

# Source files
SOURCES = $(SRC_DIR)/main.c

# Object files
OBJECTS = $(SOURCES:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)

# Default target
all: $(BUILD_DIR)/$(PROJECT).elf

# Create build directory
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Compile
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

# Link
$(BUILD_DIR)/$(PROJECT).elf: $(OBJECTS)
	$(CC) $(LDFLAGS) $^ -o $@
	$(SIZE) $@

# Clean
clean:
	rm -rf $(BUILD_DIR)

.PHONY: all clean