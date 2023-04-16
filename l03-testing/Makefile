main: main.o
	ld -o main main.o

main.o: main.s
	as -o main.o main.s

all: main

clean:
	rm main main.o

test: main
	./main 0<test/input.dat 1>test/output.out
	diff test/output.out test/output.dat
