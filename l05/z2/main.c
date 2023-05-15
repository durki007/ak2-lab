#include <stdio.h>

extern long int measure();

int main()
{
    for(int i=0; i<29;i++){
    long int result = measure();
    long int result2 = measure();
    printf("Result: %ld\n", result);
    printf("Result2: %ld\n", result2);
    printf("Diff: %ld\n", result2 - result);
    }
    return 0;
}
