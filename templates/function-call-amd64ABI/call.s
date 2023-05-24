; Function to add two integers
; int add(int a, int b)

section .text
global add
add:
    ; Prologue
    push rbp
    mov rbp, rsp

    ; Save callee-saved registers on the stack
    push rbx
    push r12
    push r13
    push r14
    push r15

    ; Move arguments to registers
    mov ebx, edi ; a -> EBX
    mov ecx, esi ; b -> ECX

    ; Add the integers
    add ebx, ecx

    ; Move the result to RAX
    mov eax, ebx

    ; Epilogue
    ; Restore callee-saved registers from the stack
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx

    ; Restore RBP and return to the caller
    mov rsp, rbp
    pop rbp
    ret
