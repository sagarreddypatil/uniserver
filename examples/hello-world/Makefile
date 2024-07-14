CC = clang
CFLAGS = --target=wasm32 -nostdlib -Wl,--import-undefined

TARGET = main

all: $(TARGET).wasm

$(TARGET).wasm: main.c
	$(CC) $(CFLAGS) main.c -o $(TARGET).wasm

clean:
	rm -f $(TARGET)
