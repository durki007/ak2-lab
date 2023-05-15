.text
.globl  measure	
.type	measure, @function

measure:
	subq	$8, %rsp
    
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

