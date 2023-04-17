// Function call template 

# (C) Michał Durkalec
# 263917@student.pwr.edu.pl
# Numbers of kernel functions.
EXIT_NR  = 1
READ_NR  = 3
WRITE_NR = 4

STDOUT = 1
STDIN = 0
EXIT_CODE_SUCCESS = 0
BUF_SIZE = 100 

.bss
len: .fill 10, 1, 0x00
buf: .fill BUF_SIZE, 1, 0x00

.text

// Parameters: rdi, rsi, rdx
// Return value: rax
.global _start
.global func

func:
    // Subroutine prologue
    sub $0x8, %rsp /* Make space for function variables */
    push %rbx
    push %rbp

    // Subroutine body
    mov $0x100, %rax

    // Subroutine epilogue
    pop %rbp
    pop %rbx
    add $0x8, %rsp
    ret

_start:

mov $0x0, %rax
call func
nop

mov $EXIT_NR          , %eax
mov $EXIT_CODE_SUCCESS, %ebx 
int $0x80
