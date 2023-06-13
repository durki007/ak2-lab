#include "stdio.h"

void print_quad(unsigned long int x) {
  printf("0x%lx\n", x);
  return;
}

unsigned long int pack_words(unsigned long int a, unsigned long int b,
                             unsigned long int c, unsigned long int d) {
  // Mask
  a &= 0x0000ffff;
  b &= 0x0000ffff;
  c &= 0x0000ffff;
  d &= 0x0000ffff;
  // Shift
  a <<= 48;

  c <<= 16;
  // Return sum
  return a + b + c + d;
}

long int unpack(unsigned long int x, unsigned long int y, unsigned long last) {
  short *t1 = (short *)&x;
  short *t2 = (short *)&y;
  long int a = t1[0] + t1[1] + t1[2] + t1[3];
  a *= 2;
  a += last;
  long int b = t2[0] + t2[1] + t2[2] + t2[3];
  b *= 2;
  return (a + b + 765) / 6;
}
