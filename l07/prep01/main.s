.data
long1: .dc.w 0x0080, 0x0001, 0x0001, 0x0001
longres: .space 8

.text
.globl	main
.type	main, @function

main:
    subq	$8, %rsp

    // Init MMX
    call    mmx_init

    movq    (long1), %rdi
    call    print_quad

    // Load values to MMX registers
    movq    (long1), %mm0
    movq    (long1), %mm1

    // Add
    paddusw   %mm1, %mm0

    movq    %mm0, %rdi
    call    print_quad

    // Pack to words
    movq    $1, %rdi
    movq    $1, %rsi
    movq    $1, %rdx
    movq    $1, %rcx
    call    pack_words
    movq    %rax, %rdi
    call    print_quad

    // Main end
	xorl	%eax, %eax
	addq	$8, %rsp
    ret

.globl    mmx_init
.type    mmx_init, @function

mmx_init:
    subq    $8, %rsp

    // Epmty MMX state
    emms

    xorl    %eax, %eax
    addq    $8, %rsp
    ret
