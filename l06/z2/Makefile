main: main.s
	gcc -o main main.s -static -g

all: main

clean:
	rm main 

test: main
	./main 1>test/output.out

run: main
	./main
