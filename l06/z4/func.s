.data
float1: .float 1.0 
float2: .float 2.0
float3: .float 3.0
floatres: .float 0.0

fcw: .space 2
fsw: .space 2

.text
.globl  measure	
.type	measure, @function
measure:
    subq	  $8, %rsp
    xor     %rax, %rax
    xor     %rdx, %rdx
    cpuid
    rdtsc     
    // Time stored in %edx:%eax
    rol     $32, %rdx
    movl    %eax, %edx
    mov     %rdx, %rax

    addq	$8, %rsp
    ret

.globl sequential 
.type	sequential, @function
sequential:
    subq  $8, %rsp  

    movl    $100, %ecx
    // Loop 100 times
    sequnetial_loop:

    fld1
    fld1
    fld1
    fld1

    // Perform (2 + 3) * 1
    faddp
    faddp

    decl    %ecx
    cmpl    $0, %ecx
    jne     sequnetial_loop

    xor   %rax, %rax
    addq	$8, %rsp
    ret

.globl paralel 
.type	paralel, @function
paralel:
    subq  $8, %rsp  

    movl    $100, %ecx
    // Loop 100 times
    paralel_loop:

    fld1
    fld1
    faddp

    fld1
    fld1
    faddp

    decl    %ecx
    cmpl    $0, %ecx
    jne     paralel_loop

    xor   %rax, %rax
    addq	$8, %rsp
    ret

.globl init_fpu 
.type	init_fpu, @function
init_fpu:
    subq  $8, %rsp  

    // Initialize FPU
    finit

    // Set float mode
    fstcw   fcw
    movw    fcw, %ax
    // 32 bit float mode
    andw    $0xf0ff, %ax
    // Round to +inf
    orw     $0x0800, %ax
    movw    %ax, fcw
    fldcw   fcw

    xor   %rax, %rax
    addq	$8, %rsp
    ret
