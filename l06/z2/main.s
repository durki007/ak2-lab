.data
float1: .float 0.1
float2: .float 0.2
floatres: .float 0.0
double1: .double 0.1
double2: .double 0.2
doubleres: .double 0.0

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

	mov     double1, %rdi
	call    print_double

	mov     double2, %rdi
	call    print_double

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
    flds    float2
    flds    float1
    faddp
    // Store result
    fstpl   doubleres
    // Store status word
    fstsw   fsw
    call    print_sw

    // Print result
    mov     doubleres, %rdi
    call    print_result_double

    // Set double mode
    fstcw   fcw
    movw    fcw, %ax
    // 64 bit double mode
    orw     $0x0200, %ax
    movw    %ax, fcw
    fldcw   fcw

    // Load 
    fldl    double2
    fldl    double1
    faddp

    // Store result
    fstpl   doubleres

    // Store status word
    fstsw   fsw
    call    print_sw

    // Print result
    mov     doubleres, %rdi
    call    print_result_double

    // Main end
	xorl	%eax, %eax
	addq	$8, %rsp
    ret

