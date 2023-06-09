#include "stdio.h"

extern long int measure();
extern void init_fpu();
extern void sequential();
extern void paralel();

int main() {
  long int result = measure();
  long int result2 = measure();
  printf("Result: %ld\n", result);
  printf("Result2: %ld\n", result2);
  printf("Diff: %ld\n", result2 - result);
  return 0;
}
