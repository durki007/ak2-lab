.data
float1: .float 1.0 
float2: .float 3.0
floatres: .float 0.0

fcw: .space 2
fsw: .space 2

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

.globl sequential 
.type	sequential, @function
sequential:
  subq  $8, %rsp  
  xor   %rax, %rax
	addq	$8, %rsp
  ret

.globl paralel 
.type	paralel, @function
paralel:
  subq  $8, %rsp  
  xor   %rax, %rax
	addq	$8, %rsp
  ret

.globl init_fpu 
.type	init_fpu, @function
init_fpu:
  subq  $8, %rsp  

  xor   %rax, %rax
	addq	$8, %rsp
  ret
