.data
kernel: .dc.b 1, 1, 1, 0, -1, -1, -1, 0 
shuffle_mask: .dc.b 1, 0, 3, 2, 5, 4, 7, 6 
.text
.globl convolute
.type	convolute, @function
// RDI: Pointer to first row
// RSI: Pointer to second row
// RDX: Pointer to last row
convolute:
    subq	$8, %rsp
    // Load values 
    //   leaq    (%rdi), %rdi
    //   movw    (%rdi), %ax
    //   leaq    (%rdx), %rdx
    //   movw    (%rdx), %bx
    //   leaq    (%rsi), %rsi
    //   movl    (%rsi), %ecx
    //   // Assemble values into RAX
    //   shlq    $32, %rax
    //   movl    %ecx, %eax
    //   shlq    $8, %rax
    //   movw    %bx, %ax
    // Move to MMX
    movq    %rdi, %mm0
    movq    %rdi, %mm1
    // Load kernel
    leaq    kernel(%rip), %rdi
    movq    (%rdi), %mm2
    // Load shuffle mask
    leaq    shuffle_mask(%rip), %rdi
    movq    (%rdi), %mm3
    // Vertical multiply and add to words
    pmaddubsw %mm2, %mm0
    // Shuffle bytes in kernel and input
    pshufb  %mm3, %mm1
    pshufb  %mm3, %mm2
    // Vertical multiply and add to words
    pmaddubsw %mm2, %mm1

    // Store results to GPR
    movq    %mm0, %rdi
    movq    %mm1, %rsi
    call    unpack

    addq	$8, %rsp
    ret
