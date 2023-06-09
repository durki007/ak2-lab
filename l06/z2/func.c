#include "stdio.h"

void print_float(unsigned int x) {
  float *f = (float *)&x;
  printf("Float value: %f \n", *f);
}

void print_result_float(unsigned int x) {
  float *f = (float *)&x;
  printf("Float result: %.30f \n", *f);
  // Get parts of float
  unsigned int sign = x >> 31;
  unsigned int exp = (x >> 23) & 0xff;
  unsigned int mant = x & 0x7fffff;
  // Print in hex
  printf("Sign: 0x%x Exp: 0x%x Mant: 0x%x \n", sign, exp, mant);
  // Print in decimal
  int sign_dec = sign ? -1 : 1;
  int exp_dec = exp - 127;
  float mant_dec = 1 + (float)mant / 0x7fffff;
  printf("Sign: %d Exp: %d Mant: %f \n", sign_dec, exp_dec, mant_dec);
}

void print_double(unsigned long int x) {
  double *d = (double *)&x;
  printf("Double value: %lf \n", *d);
}

void print_result_double(unsigned long int x) {
  double *d = (double *)&x;
  printf("Double result: %.30lf \n", *d);
  // Get parts of double
  unsigned long int sign = x >> 63;
  unsigned long int exp = (x >> 52) & 0x7ff;
  unsigned long int mant = x & 0xfffffffffffff;
  // Print in hex
  printf("Sign: 0x%lx Exp: 0x%lx Mant: 0x%lx \n", sign, exp, mant);
  // Print in decimal
  int sign_dec = sign ? -1 : 1;
  long int exp_dec = exp - 1023;
  double mant_dec = 1 + (double)mant / 0xfffffffffffff;
  printf("Sign: %d Exp: %ld Mant: %lf \n", sign_dec, exp_dec, mant_dec);
}
