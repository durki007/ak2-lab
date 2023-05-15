.data
.globl msg
temp:
    .string "Hello, from asm!\n"
msg:
    .quad temp
