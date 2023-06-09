.data
float1: .int 0x33800000
float2: .int 0x3fc00000
float3: .int 0x34000000
floatres: .float 4.0
fcw: .space 2
fsw: .space 2

int_1: .int 1
int_2: .int 2

fmt_float: .string "Wynik operacji: 0x%x\n"
fmt_sw: .string "Status word: 0x%x\n"

.text
.globl	main
.type	main, @function

main:
	subq	$8, %rsp

    // Initialize FPU
    finit

    // Set float mode
    fstcw   fcw
    movw    fcw, %ax
    // 32 bit float mode
    andw    $0xfcff, %ax
    movw    %ax, fcw
    fldcw   fcw

    // Load 1.0 to FPU
    flds    float1
    flds    float3
    faddp
    // Store result
    fstps    floatres
    // Store status word
    fstsw   fsw
    xorq    %rax, %rax
    movw    fsw, %ax

    // Print status word
    leaq    fmt_sw(%rip), %rdi
    movq    %rax, %rsi
    call    printf

    // Print result
	leaq	fmt_float(%rip), %rdi
    movq	floatres(%rip), %rsi
    call    printf

    // Main end
	xorl	%eax, %eax
	addq	$8, %rsp
    ret

