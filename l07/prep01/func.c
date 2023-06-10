#include "stdio.h"

void print_quad(unsigned long int x) {
  printf("0x%lx\n", x);
  return;
}

unsigned long int pack_words(unsigned long int a, unsigned long int b, unsigned long int c, unsigned long int d){
  // Mask
  a &= 0x0000ffff;
  b &= 0x0000ffff;
  c &= 0x0000ffff;
  d &= 0x0000ffff;
  // Shift 
  a <<= 48;
  b <<= 32;
  c <<= 16;
  // Return sum
  return a + b + c + d;
}
