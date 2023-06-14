.data
kernel:
// Needs to be reversed .dc.b -1, -1, 0, -1, 0, 1, 0, 1, 1
.dc.b 1, 0, 1, 0, -1, 0, -1, -1
div2:
.dc.b 1, 1, 1, 1, 1, 1, 1, 1
.text
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
