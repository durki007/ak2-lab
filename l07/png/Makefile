png: png.c func.s
	gcc -o png png.c func.s -g -lpng -fPIE -O4
all: png 

clean:
	rm png 

run: png
	./png png_images/1.png
	feh out.png
	feh png_images/1_emboss.png

test: png
	./png png_images/1.png
	feh out.png png_images/1_emboss.png
	./png png_images/car.png
	feh out.png png_images/car_emboss.png
	./png png_images/tiger.png
	feh out.png png_images/tiger_emboss.png

profile: png
	gcc -o png png.c func.s -g -lpng -fPIE -O4 -pg
	

debug: png
	gdb --args png png_images/1.png 
