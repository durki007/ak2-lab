#include "stdio.h"

void print_quad(unsigned long int x) {
  printf("0x%lx\n", x);
  return;
}

void print_long(long int x) {
  printf("%ld\n", x);
  return;
}

void print_sep() { printf("----\n"); }

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

long int unpack(unsigned long int x, unsigned long int y, long last) {
  print_sep();
  print_long(last);
  print_quad(x);
  print_quad(y);
  short *t1 = (short *)&x;
  short *t2 = (short *)&y;
  long int a = t1[0] + t1[1] + t1[2] + t1[3];
  long int b = t2[0] + t2[1] + t2[2] + t2[3];
  print_long(a);
  print_long(b);
  long int sum = a + b + last;
  long int normalised = ((sum) / 6) + 128;
  // if (normalised > 255 || normalised < 0) {
  //   printf("%ld", normalised);
  // }
  return normalised;
}
