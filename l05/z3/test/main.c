#include <stdio.h>

extern char *msg;
char *msg2 = "Hello, World!";

int main()
{
    printf("Local var: %s\n", msg2);
    printf("%s\n", msg);
    return 0;
}
