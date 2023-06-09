.data
float1: .float 2.0
float2: .float 2.0
floatres: .float 4.0
fcw: .space 2
fsw: .space 2

int_1: .int 1
int_2: .int 2

fmt_float: .string "Wynik operacji [hex]: %x\n"
fmt_sw: .string "Status word: %x\n"

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
    // Load to FPU
    fldz
    flds    float1 
    // Divide
    fdivp
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

