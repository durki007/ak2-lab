# (C) Michał Durkalec
# 263917@student.pwr.edu.pl

// Zalozenia ogolne
// In sieve:
// 0 -> prime number
// 1 -> not prime number

# Numbers of kernel functions.
EXIT_NR  = 1
READ_NR  = 3
WRITE_NR = 4

STDOUT = 1
STDIN = 0
EXIT_CODE_SUCCESS = 0

// Global variables
N = 0x40000000 
BUF_SIZE = (N / 8) + 0 

.bss
buf: .fill BUF_SIZE+10, 1, 0x00

.text

.global _start
.global set_bit
.global reset_bit 
.global complement_buffer

// Set n-th bit
// n - %rdi - bit number
set_bit:
    // Subroutine prologue
    sub $0x8, %rsp /* Make space for function variables */
    push %rbx
    push %rbp

    // Set bit in string 
    mov $buf, %rbx
    bts %rdi, (%rbx)

    // Subroutine epilogue
    pop %rbp
    pop %rbx
    add $0x8, %rsp
    ret
reset_bit:
    // Subroutine prologue
    sub $0x8, %rsp /* Make space for function variables */
    push %rbx
    push %rbp

    // Set bit in string 
    mov $buf, %rbx
    btr %rdi, (%rbx)

    // Subroutine epilogue
    pop %rbp
    pop %rbx
    add $0x8, %rsp
    ret

// Set all multiplies of rdi to 1
// In:
//      rdi -> start index
sieve:
    // Subroutine prologue
    sub $0x8, %rsp /* Make space for function variables */
    push %rbx
    push %rbp
    push %rsi
    push %rdi

    mov %rdi, %rsi
    jmp sieve_while
    sieve_do:
    // Correct bit numer already in rdi
    call set_bit

    sieve_while:
    add %rsi, %rdi /* Increase rdi by rsi */
    cmp $N, %rdi
    jle sieve_do /* Jump if less or equal */

    // Subroutine epilogue
    pop %rdi
    pop %rsi
    pop %rbp
    pop %rbx
    add $0x8, %rsp
    ret

// Complements every bit in whole BUF
complement_buffer:
    // Subroutine prologue
    sub $0x8, %rsp /* Make space for function variables */
    push %rbx
    push %rbp
    push %rsi
    push %rdi

    mov $0, %rdi
    cb_do:
    mov $buf, %rbx
    btc %rdi, (%rbx)
    cb_while:
    inc %rdi /* Increase rdi by rsi */
    cmp $N, %rdi
    jle cb_do /* Jump if less or equal */

    // Subroutine epilogue
    pop %rdi
    pop %rsi
    pop %rbp
    pop %rbx
    add $0x8, %rsp
    ret

_start:
// Main loop
// Start at 2
mov $2, %rsi
do:
    // Check if bit is set
    mov %rsi, %rdi
    mov $buf, %rbx
    bt  %rsi, (%rbx)
    // Result in CF
    // If set skip next part
    jc while
    // Here call sieve loop
    mov %rsi, %rdi
    call sieve


while:
    inc %rsi
    cmp $N, %rsi
    jle do /* Jump if less or equal */

// Complement bits to meet requirements

call complement_buffer

// Write
mov $WRITE_NR, %eax 
mov $STDOUT  , %ebx 
mov $buf, %ecx 
mov $BUF_SIZE, %edx 
int $0x80

mov $EXIT_NR          , %eax
mov $EXIT_CODE_SUCCESS, %ebx 
int $0x80
