.data
long1: .dc.w 0x0080, 0x0001, 0x0001, 0x0001
longres: .space 8
bytes: .dc.b 4, 4, 4, 4, 4, 4, 4, 4
div2: .dc.b 1, 1, 1, 1, 1, 1, 1, 1
kernel:
.dc.b -1, -1, 0, -1, 0, 1, 0, 1
m1: .space 8
m2: .space 8

.text
.globl	main
.type	main, @function

main:
    subq	$8, %rsp

    // Init MMX
    call    mmx_init

    movq    (bytes), %rdi
    movq    $1, %rsi
    call    convolute

    movq    %rax, %rdi
    call    print_quad

    // Main end
	xorl	%eax, %eax
	addq	$8, %rsp
    ret

.globl convolute
.type	convolute, @function
convolute:
    subq	$8, %rsp
    // Clean mmx
    emms
    movq    %rsi, %rdx
    // Load matrix to mmx registers
    // First 8 bytes
    movq    %rdi, %mm0
    // Divide by 2
    // movq    $2, %rdi
    // movq    %rdi, %mm1
    // psrlq   %mm1, %mm0
    // Copy 8 high bytes to mm1 
    movq    %mm0, %rsi
    shrq    $32, %rsi
    movq    %rsi, %mm1

    // Load kernel
    leaq    kernel(%rip), %rdi
    movq    (%rdi), %mm2
    // Multiply and add
    pmaddubsw %mm2, %mm0
    pmaddubsw %mm2, %mm1

    movq %mm0, %rdi
    movq %mm1, %rsi

    call    unpack

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
