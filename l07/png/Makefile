png: png.c func.s
	gcc -o png png.c func.s -g -lpng -fPIE
all: png 

clean:
	rm png 

run: png
	./png png_images/1.png
	feh out.png
	feh png_images/1_emboss.png

debug: png
	gdb --args png png_images/1.png 
