#include <stdio.h>

extern char *msg;
char *msg2 = "Hello, World!\n";
char *cmsg = "Printed from asm\n";

extern void print_asm();

int main()
{
    print_asm();
    printf("Local var: %s\n", msg2);
    printf("%s\n", msg);
    return 0;
}
