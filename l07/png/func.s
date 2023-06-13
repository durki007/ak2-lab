.data
kernel:
.dc.b -1, -1, 0, -1, 0, 1, 0, 1, 1
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
    // Load kernel to mmx registers
    // First 8 bytes
    movq    %rdi, %mm0
    // Divide by 2
    leaq    div2(%rip), %rdi
    movq    (%rdi), %mm1
    psrlq   %mm1, %mm0
    // Copy to mm3
    movq    %mm0, %rsi
    shrq    $32, %rsi

    // Load kernel
    leaq    kernel(%rip), %rdi
    movq    (%rdi), %mm1
    // Multiply and add
    pmaddubsw %mm1, %mm0
    movq    %mm0, %rdi
    // Repeat
    movq    %rsi, %mm0
    pmaddubsw %mm1, %mm0
    movq    %mm0, %rsi

    call    unpack

    addq	$8, %rsp
    ret
