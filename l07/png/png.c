#include <png.h>
#include <stdio.h>
#include <stdlib.h>

#define ERROR                                                                  \
  fprintf(stderr, "ERROR at %s:%d.\n", __FILE__, __LINE__);                    \
  return -1;

extern unsigned char convolute(unsigned long first8, unsigned long last);

void filter(unsigned char *M, unsigned char *W, int width, int height) {
  for (int i = 0; i < width * (height - 2) - 1; i++) {
    // Assemble first 8 bytes of matrix
    unsigned long x = 0;
    unsigned int width2 = width << 1;
    // Można zrobić szybciej (po 3 naraz)
    x += M[i];
    x <<= 8;
    x += M[i + 1];
    x <<= 8;
    x += M[i + 2];
    x <<= 8;
    x += M[i + width];
    x <<= 8;
    x += M[i + width + 1];
    x <<= 8;
    x += M[i + width + 2];
    x <<= 8;
    x += M[i + width2];
    x <<= 8;
    x += M[i + width2 + 1];
    W[i + width + 1] = convolute(x, M[i + width2 + 2]);
  }
}

long int unpack(unsigned long int x, unsigned long int y, unsigned long last) {
  short *t1 = (short *)&x;
  short *t2 = (short *)&y;
  long int a = t1[0] + t1[1] + t1[2] + t1[3];
  long int b = t2[0] + t2[1] + t2[2] + t2[3];
  long int sum = a + b + last;
  long int normalised = ((sum) / 6) + 128;
  if (normalised > 255 || normalised < 0) {
    printf("%ld", normalised);
  }
  return normalised;
}

int main(int argc, char **argv) {
  if (2 != argc) {
    printf("\nUsage:\n\n%s file_name.png\n\n", argv[0]);

    return 0;
  }

  const char *file_name = argv[1];

#define HEADER_SIZE (1)
  unsigned char header[HEADER_SIZE];

  FILE *fp = fopen(file_name, "rb");
  if (NULL == fp) {
    fprintf(stderr, "Can not open file \"%s\".\n", file_name);
    ERROR
  }

  if (fread(header, 1, HEADER_SIZE, fp) != HEADER_SIZE) {
    ERROR
  }

  if (0 != png_sig_cmp(header, 0, HEADER_SIZE)) {
    ERROR
  }

  png_structp png_ptr =
      png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
  if (NULL == png_ptr) {
    ERROR
  }

  png_infop info_ptr = png_create_info_struct(png_ptr);
  if (NULL == info_ptr) {
    png_destroy_read_struct(&png_ptr, NULL, NULL);

    ERROR
  }

  if (setjmp(png_jmpbuf(png_ptr))) {
    png_destroy_read_struct(&png_ptr, &info_ptr, NULL);

    ERROR
  }

  png_init_io(png_ptr, fp);
  png_set_sig_bytes(png_ptr, HEADER_SIZE);
  png_read_info(png_ptr, info_ptr);

  png_uint_32 width, height;
  int bit_depth, color_type;

  png_get_IHDR(png_ptr, info_ptr, &width, &height, &bit_depth, &color_type,
               NULL, NULL, NULL);

  if (8 != bit_depth) {
    ERROR
  }
  if (0 != color_type) {
    ERROR
  }

  size_t size = width;
  size *= height;

  unsigned char *M = malloc(size);

  png_bytep ps[height];
  ps[0] = M;
  for (unsigned i = 1; i < height; i++) {
    ps[i] = ps[i - 1] + width;
  }
  png_set_rows(png_ptr, info_ptr, ps);
  png_read_image(png_ptr, ps);

  printf("Image %s loaded:\n"
         "\twidth      = %lu\n"
         "\theight     = %lu\n"
         "\tbit_depth  = %u\n"
         "\tcolor_type = %u\n",
         file_name, width, height, bit_depth, color_type);

  unsigned char *W = malloc(size);

  filter(M, W, width, height);

  png_structp write_png_ptr =
      png_create_write_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
  if (NULL == write_png_ptr) {
    ERROR
  }

  for (unsigned i = 0; i < height; i++) {
    ps[i] += W - M;
  }
  png_set_rows(write_png_ptr, info_ptr, ps);

  FILE *fwp = fopen("out.png", "wb");
  if (NULL == fwp) {
    ERROR
  }

  png_init_io(write_png_ptr, fwp);
  png_write_png(write_png_ptr, info_ptr, PNG_TRANSFORM_IDENTITY, NULL);
  fclose(fwp);

  return 0;
}
