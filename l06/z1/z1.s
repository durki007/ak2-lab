.data
float1: .space 4 
float2: .space 4
floatres: .space 4
float_mode: .byte 0x00, 0x00

int_1: .int 1
int_2: .int 2

fmt_float: .string "%x\n"

.text
.globl	main
.type	main, @function

main:
	subq	$8, %rsp
    // Initialize FPU
    finit
    fldcw   float_mode
    // Load to memory
    movl    $0x3f800000, %eax
    mov     %eax, float1
    movl    $0x40000000, %eax
    movl    %eax, float2
    // Load to FPU
    fldl    float1 
    fldl    float2
    // Add
    fadd    %st(0), %st(1)
    // Store result
    fstpl    floatres

    // Move to registers
    movl    float1, %eax
    movl    float2, %ebx
    movl    floatres, %ecx

    // Print result
	leaq	fmt_float(%rip), %rdi
    movq	float1(%rip), %rsi
    call    printf

	leaq	fmt_float(%rip), %rdi
    movq	float2(%rip), %rsi
    call    printf

	leaq	fmt_float(%rip), %rdi
    movq	floatres(%rip), %rsi
    call    printf

	xorl	%eax, %eax
	addq	$8, %rsp
    ret

