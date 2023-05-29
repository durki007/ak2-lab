#include "stdio.h"

float add(float a, float b) {
    return a + b;
}

int main() {
    float a = add(1.0, 2.0);
    printf("a = %f\n", a);
    return 0;
}
