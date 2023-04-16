# Numbers of kernel functions.
EXIT_NR  = 1
READ_NR  = 3
WRITE_NR = 4

STDOUT = 1
STDIN = 0
EXIT_CODE_SUCCESS = 0

.data
len: .fill 10, 1, 0x00
msg: .fill 200, 1, 0x00

.text

.global _start

_start:
// Read
mov $READ_NR, %eax 
mov $STDIN, %ebx 
mov $msg, %ecx 
mov $20, %edx 
int $0x80
mov %eax, len

// Loop
movl (len), %ecx
sub

// Write
mov $WRITE_NR, %eax 
mov $STDOUT  , %ebx 
mov $msg     , %ecx 
mov (len), %edx 
int $0x80


mov $EXIT_NR          , %eax
mov $EXIT_CODE_SUCCESS, %ebx 
int $0x80
