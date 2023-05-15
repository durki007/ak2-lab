.text
.globl	main
.type	main, @function

main:
	subq	$8, %rsp
    // Call printf 
	leaq	hello(%rip), %rax
	movq	%rax, %rdi
    call    printf

    // Call scanf
    leaq    fmt(%rip), %rax
    movq    %rax, %rdi
    leaq    msg(%rip), %rax
    movq    %rax, %rsi
    call    scanf

    // Call printf again
    leaq    fmt2(%rip), %rdi
    leaq    msg(%rip), %rsi
    call    printf

    // Print int val
    leaq    fmt_int(%rip), %rdi
    mov     $20, %rsi
    call    printf

    // Scanf short
    leaq    fmt_short(%rip), %rdi
    leaq    short(%rip), %rsi
    call    scanf

    // Print short
    leaq    fmt_short2(%rip), %rdi
    movw    short(%rip), %si
    call    printf

	xorl	%eax, %eax
	addq	$8, %rsp
    ret

.data
hello:
    .string "Hello, world!\n"
fmt:
    .string "%s"
fmt2:
    .string "%s\n"
fmt_int:
    .string "%d\n"
fmt_short:
    .string "%hd"
fmt_short2:
    .string "%hd\n"

.bss
msg: .fill 100, 1, 0x00
short: .space 2 

