#include "stdio.h"

void print_float(unsigned int x) {
  float *f = (float *)&x;
  printf("Float value: %f \n", *f);
}

void print_result_float(unsigned int x) {
  float *f = (float *)&x;
  printf("Float result: %f \n", *f);
  // Print in hex
  printf("Float result in hex: 0x%x \n", x);
}

void print_double(unsigned long int x) {
  double *d = (double *)&x;
  printf("Double value: %lf \n", *d);
}

void print_result_double(unsigned long int x) {
  double *d = (double *)&x;
  printf("Double result: %lf \n", *d);
  // Print in hex
  printf("Double result in hex: 0x%lx \n", x);
}
