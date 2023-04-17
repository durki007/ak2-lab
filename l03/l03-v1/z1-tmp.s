# Numbers of kernel functions.
EXIT_NR  = 1
READ_NR  = 3
WRITE_NR = 4

STDOUT = 1
STDIN = 0
EXIT_CODE_SUCCESS = 0
BUF_SIZE = 2 

.data
len: .fill 10, 1, 0x00
buf: .fill BUF_SIZE, 1, 0x00

.text

.global _start

_start:

do:
    // Read
    mov $READ_NR, %eax 
    mov $STDIN, %ebx 
    mov $buf, %ecx 
    mov $BUF_SIZE, %edx 
    int $0x80
    mov %eax, len

    // Manipulate
l_set:
    mov $0, %ecx
l_mid:
    movl $buf, %eax
    movl (%eax, %ecx, 4), %ebx
    inc %ebx
    movl %ebx, (%eax, %ecx, 4)
    inc %ecx
l_cond:
    cmpl (len), %ecx
    jl l_mid

    // Write
    mov $WRITE_NR, %eax 
    mov $STDOUT  , %ebx 
    mov $buf, %ecx 
    mov (len), %edx 
    int $0x80

while:
    mov (len), %eax
    cmpl $1, %eax 
    jge do

mov $EXIT_NR          , %eax
mov $EXIT_CODE_SUCCESS, %ebx 
int $0x80
