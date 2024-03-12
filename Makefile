# Define variables
SRCDIR := src
BINDIR := bin
OBJDIR := obj

# Get all subdirectories recursively
SUBDIRS := $(shell find $(SRCDIR) -type d)

# Define source and object files
SRCS := $(wildcard $(addsuffix /*.c,$(SUBDIRS)))
OBJS := $(patsubst $(SRCDIR)/%.c,$(OBJDIR)/%.o,$(SRCS))

# Compiler and flags
CC := gcc
CFLAGS := -Wall -Wextra

# Main target
TARGET := app

# Create directories before building
all: create_dirs $(BINDIR)/$(TARGET)

create_dirs:
	mkdir -p $(BINDIR) $(OBJDIR)

$(BINDIR)/$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $^ -o $@

$(OBJDIR)/%.o: $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean run create_dirs

clean:
	rm -rf $(BINDIR)/* $(OBJDIR)/*

run: $(BINDIR)/$(TARGET)
	./$(BINDIR)/$(TARGET)

# Phony targets
.PHONY: all clean run
