.extern printf

.section .data
hello:
    .string "Hello, world!\n"

.section .text
.globl _start
_start:
    # Push the address of the string onto the stack
    push $hello

    # Call the printf function
    call printf

    # Clean up the stack
    addl $4, %esp

    # Exit the program with status code 0
    xorl %eax, %eax
    movl $1, %ebx
    int $0x80
