CARGO := cargo
TARGET_DIR := target
RELEASE_DIR := $(TARGET_DIR)/release
DEBUG_DIR := $(TARGET_DIR)/debug

EXAMPLES_DIR := examples

# Find all subdirectories in the examples directory
EXAMPLE_SUBDIRS := $(wildcard $(EXAMPLES_DIR)/*/)

# Default target
.PHONY: all
all: build

# Build the project in debug mode
.PHONY: build
build:
	$(CARGO) build

# Build the project in release mode
.PHONY: release
release:
	$(CARGO) build --release

# Run the project
.PHONY: run
run:
	$(CARGO) run


# Build examples
.PHONY: examples $(EXAMPLE_SUBDIRS)
examples: bin/examples $(EXAMPLE_SUBDIRS)

# Rule for building each example
$(EXAMPLE_SUBDIRS):
	@if [ -f $@/Makefile ]; then \
		echo "Running Makefile for $@"; \
		$(MAKE) -C $@ TARGET=$(PWD)/bin/$(@D); \
	else \
		echo "Error: Makefile not found in $@. All examples must have a Makefile."; \
		exit 1; \
	fi

bin:
	mkdir -p bin

bin/examples: bin
	mkdir -p bin/examples
