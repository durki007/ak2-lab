	.file	"var.c"
	.text
	.globl	msg
	.section	.rodata
.LC0:
	.string	"Hello, world!\n"
	.section	.data.rel.local,"aw"
	.align 8
	.type	msg, @object
	.size	msg, 8
msg:
	.quad	.LC0
	.ident	"GCC: (GNU) 12.2.1 20230201"
	.section	.note.GNU-stack,"",@progbits
