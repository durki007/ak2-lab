#include "stdio.h"

extern long int measure();
extern void init_fpu();
extern void sequential();
extern void paralel();

unsigned long int measure_sequential() {
  unsigned long int result = 0;
  for (int i = 0; i < 100; i++) {
    long int start = measure();
    sequential();
    long int end = measure();
    result += end - start;
  }
  return result / 100;
};

unsigned long int measure_paralel() {
  unsigned long int result = 0;
  for (int i = 0; i < 100; i++) {
    long int start = measure();
    paralel();
    long int end = measure();
    result += end - start;
  }
  return result / 100;
};

int main() {
  init_fpu();
  unsigned long int sequential_time = measure_sequential();
  unsigned long int paralel_time = measure_paralel();
  printf("Sequential time: %lu\n", sequential_time);
  printf("Paralel time: %lu\n", paralel_time);
  return 0;
}
