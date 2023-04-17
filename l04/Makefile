main: main.o
	ld -o main main.o

main.o: main.s
	as -g -o main.o main.s

all: main

clean:
	rm main main.o

test: main
	./main 1>test/output.out
