#include "stdio.h"

int p() {
  int r;
  scanf("%d", &r);
  return r;
}

int main() {
  printf("%d\n", p());
  return 0;
}
