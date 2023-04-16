# Numbers of kernel functions.
EXIT_NR  = 1
READ_NR  = 3
WRITE_NR = 4

STDOUT = 1
EXIT_CODE_SUCCESS = 0

.data
msg: .ascii "Witaj\n"
msgLen = . - msg

.text
msg2: .ascii "Hello\n"
msg2Len = . - msg2


.global _start
_start:

// mov $0x0, %eax
// movb $0x41, (%eax) 
movb $0x41, msg
mov $WRITE_NR, %eax 
mov $STDOUT  , %ebx 
mov $msg     , %ecx 
mov $msgLen, %edx 
int $0x80

mov $WRITE_NR, %eax 
mov $STDOUT  , %ebx 
mov $msg2     , %ecx 
mov $msg2Len, %edx 
int $0x80

mov $EXIT_NR          , %eax
mov $EXIT_CODE_SUCCESS, %ebx 
int $0x80

