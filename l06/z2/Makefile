main: main.s func.c
	gcc -o main main.s func.c -static -g

all: main

clean:
	rm main 

run: main
	./main
