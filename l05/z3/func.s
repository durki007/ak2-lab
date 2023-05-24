.text
.extern cmsg
.globl  print_asm
.type	print_asm, @function

print_asm:
	subq	$8, %rsp
    
    // print the string 
    leaq    fmt(%rip), %rdi
    // leaq    mes(%rip), %rsi
    // mov     cmsg, %rsi
    // leaq    mes(%rip), %rsi
    leaq    cmsg(%rip), %rsi
    mov     (%rsi), %rsi
    call    printf

    xor     %rax, %rax
	addq	$8, %rsp
    ret

.data
fmt:
    .string "%s\n"
mes:
    .quad cmsg
