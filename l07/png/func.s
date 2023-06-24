.data
kernel: .dc.b 1, 1, 1, 0, -1, -1, -1, 0 
shuffle_mask: .dc.b 1, 0, 3, 2, 5, 4, 7, 6 
// add_mask: .dc.b 1, 0, 1, 0, 1, 0, 1, 0
add_mask: .dc.w 1, 1, 1, 1
.text
.globl convolute
.type	convolute, @function
// RDI: Packed data
convolute:
    subq	$8, %rsp
    // Move to MMX
    movq    %rdi, %mm0
    // Load kernel
    leaq    kernel(%rip), %rdi
    movq    (%rdi), %mm1
    // Vertical multiply and add to words
    pmaddubsw %mm1, %mm0
    // Vertical multiply and add to integers (32b)
//   leaq    add_mask(%rip), %rdi
//   movd    (%rdi), %mm1
//   pmaddwd %mm1, %mm0

    // Store results to GPR
    movq    %mm0, %rdi
    call    unpack

    addq	$8, %rsp
    ret

.text
.globl  measure	
.type	measure, @function
measure:
    subq	$8, %rsp
    pushq   %rbx
    xor     %rax, %rax
    xor     %rdx, %rdx
    cpuid
    rdtsc     
    // Time stored in %edx:%eax
    rol     $32, %rdx
    movl    %eax, %edx
    mov     %rdx, %rax

    popq    %rbx
    addq	$8, %rsp
    ret
