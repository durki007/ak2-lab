.data
float1: .float 1.0 
float2: .float 3.0
floatres: .float 0.0

fcw: .space 2
fsw: .space 2

int_1: .int 1
int_2: .int 2

fmt_float: .string "Wynik operacji: 0x%x\n"
fmt_sw: .string "Status word: 0x%x\n"

.text

print_sw:
	subq	$8, %rsp
    // Print status word
    xorq    %rax, %rax
    movw    fsw, %ax
    leaq    fmt_sw(%rip), %rdi
    movq    %rax, %rsi
    call    printf

	xorl	%eax, %eax
	addq	$8, %rsp
    ret



.globl	main
.type	main, @function

main:
	subq	$8, %rsp

    mov     float1, %rdi
	call    print_float

	mov     float2, %rdi
	call    print_float

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
    // Load to FPU
    flds    float2
    flds    float1
    fdivp
    // Store result
    fstps   floatres
    // Store status word
    fstsw   fsw
    call    print_sw

    // Print result
    mov     floatres, %rdi
    call    print_result_float

    // Set float mode
    fstcw   fcw
    movw    fcw, %ax
    // 32 bit float mode
    andw    $0xf0ff, %ax
    // Round to -inf
    orw     $0x0400, %ax
    movw    %ax, fcw
    fldcw   fcw
    // Load to FPU
    flds    float2
    flds    float1
    fdivp
    // Store result
    fstps   floatres
    // Store status word
    fstsw   fsw
    call    print_sw

    // Print result
    mov     floatres, %rdi
    call    print_result_float

    // Main end
	xorl	%eax, %eax
	addq	$8, %rsp
    ret

