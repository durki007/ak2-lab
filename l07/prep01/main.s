.data
long1: .dc.w 0x0080, 0x0001, 0x0001, 0x0001
longres: .space 8
// Max negative
// bytes: .dc.b 1, 1, 1, 1, 255, 1, 255, 255 
// Max positive
bytes: .dc.b 10, 0, 0, 0, 0, 0, 0, 0 
// bytes: .dc.b 0, 0, 0, 0, 0, 0, 0, 0 
bytes2: .dc.b 0, 1, 2, 3, 4, 5, 6, 7 
div2: .dc.b 1, 1, 1, 1, 1, 1, 1, 1
kernel: .dc.b 1, 0, 1, 0, -1, 0, -1, -1
shuffle_mask: .dc.b 1, 0, 3, 2, 5, 4, 7, 6 
m1: .space 8
m2: .space 8

.text
.globl	main
.type	main, @function

main:
    subq	$8, %rsp

    // Init MMX
    call    mmx_init
    
    // Test shuffle
    movq    (bytes2), %rdi
    movq    %rdi, %mm0
    call    print_quad
    movq    (shuffle_mask), %rdi
    movq    %rdi, %mm3
    pushq   %rdi
    call    print_quad
    popq    %rdi
    pshufb  %mm3, %mm0
    movq    %mm0, %rdi
    call    print_quad

    call    print_sep

    // Convolute
    movq    (bytes), %rdi
    movq    $0, %rsi
    call    convolute

    pushq   %rax
    call    print_sep
    popq    %rdi
    call    print_long

    // Main end
	xorl	%eax, %eax
	addq	$8, %rsp
    ret

.globl convolute
.type	convolute, @function
convolute:
    subq	$8, %rsp
    // Store last val
    pushq   %rsi
    // Load matrix to mmx registers
    // First 8 bytes
    movq    %rdi, %mm0
    // Copy 8 high bytes to mm1 
    movq    %rdi, %mm1

    // Load kernel
    leaq    kernel(%rip), %rdi
    movq    (%rdi), %mm2
    leaq    shuffle_mask(%rip), %rdi
    movq    (%rdi), %mm3
    call    print_quad
    pushq   %rdi
    movq    %mm0, %rdi
    call    print_quad
    popq    %rdi

    // Multiply and add 
    pmaddubsw %mm2, %mm0
    movq    %mm0, %rdi
    // Shuffle kernel
    pshufb  %mm3, %mm2
    // Shuffle values
    pshufb  %mm3, %mm1

    pmaddubsw %mm2, %mm1
    movq    %mm1, %rsi

    popq    %rdx
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
