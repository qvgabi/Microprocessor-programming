#----------------------------------------------------------------
# Program LAB_6.S - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------
#
#  To compile: as -o lab_6.o lab_6.s
#  To link:    ld -o lab_6 lab_6.o
#  To run:     ./lab_6
#
#----------------------------------------------------------------


.equ	read_64,	0x00	# read data from file function
.equ	write_64,	0x01	# write data to file function
.equ	exit_64,	0x3C	# exit program function

.equ	tooval,	-1
.equ	errval,	-2

.equ    stderr, 2
.equ    stdin,0
.equ    stdout,1

	.data
	
buffer:			# buffer for file data
	.space		1024, 0
bufsize:		# size of buffer
	.quad		( . - buffer )
b_read:			# size of read data
	.quad		0
errmsg:			# file error message
	.ascii	"File error!\n"
errlen:
	.quad		( . - errmsg )
toomsg:			# file too big error message
	.ascii	"File too big!\n"
toolen:
	.quad		( . - toomsg ) 
promptmsg:
	.ascii	"String: "
promptlen:
	.quad		( . - promptmsg ) 
befmsg:
	.ascii	"Before:\n"
beflen:
	.quad		( . - befmsg ) 
aftmsg:
	.ascii	"After:\n"
aftlen:
	.quad		( . - aftmsg ) 



	.text
	.global _start
	
_start:
	NOP # slowing down the proccessor

	MOV	$write_64,%rax	# write function
	MOV	$stdout,%rdi	# file handle in RDI
	MOV	$promptmsg,%rsi	# RSI points to message
	MOV	promptlen,%rdx	# bytes to be written
	SYSCALL
	
	MOV	$read_64,%rax	# read function
	MOV	$stdin,%rdi	# file handle in RDI
	MOV	$buffer,%rsi	# RSI points to data buffer
	MOV	bufsize,%rdx	# bytes to be read
	SYSCALL

	CMP	$0,%rax
	JL	error		# if RAX<0 then something went wrong

	MOV	%rax,b_read	# store count of read bytes

	CMP	$bufsize,%rax	# whole file was read ?
	JE	toobig		# probably not

	MOV	$write_64,%rax	# write function
	MOV	$stdout,%rdi	# file handle in RDI
	MOV	$befmsg,%rsi	# RSI points to message
	MOV	beflen,%rdx	# bytes to be written
	SYSCALL

	MOV	$write_64,%rax	# write function
	MOV	$stdout,%rdi	# file handle in RDI
	MOV	$buffer,%rsi	# offset to first character
	MOV	b_read,%rdx	# count of characters
	SYSCALL

	MOV	$buffer,%rsi
	MOV	%rsi,%rdi
	MOV	b_read,%rcx
	CLD
next:
	LODSB			# al := MEM[ rsi ]; rsi++
    CMP $'0',%al
    JB skip
    CMP $'9', %al
    JA letter
    MOV $'#', %al
    JMP skip
letter:
    CMPB $'A',%al
	JB skip
	CMPB $'z', %al
    JA skip
    CMPB $'Z',%al
	JBE change
    CMPB $'a', %al
    JB skip
	# SUB $32, %al  # kody malych liter sa wieksze od odpowiadajcych im wielkich liter o 32 wiec odejmujemy 32 zeby zamienic na duze
    # zastepujemy odejmowanie iloczynem logicznym poniewaz we wszystkich kodach malych liter bit nr 5 ma wartosc 1 a w kodach wielkich liter ten sam bit wartosc 0, wiec zamieniamy bit 5 na 0
    # AND $0xDF, %al # 1101 1111 = 0xDF
    # ADD $32,%al # teraz zamiana malych na duze
    # OR $0x20, %al to samo 0010 0000=0x20
change:
    XOR $0x20, %al # zeby jednoczesnie zamieniac wielkosc liter musimy zmienic wartosc 5 bitu na przeciwny czyli XOR
    
skip:	STOSB			# MEM[ rdi ] := al; rdi++
	LOOP next

	MOV	$write_64,%rax	# write function
	MOV	$stdout,%rdi	# file handle in RDI
	MOV	$aftmsg,%rsi	# RSI points to message
	MOV	aftlen,%rdx	# bytes to be written
	SYSCALL

	MOV	$write_64,%rax	# write function
	MOV	$stdout,%rdi	# file handle in RDI
	MOV	$buffer,%rsi	# offset to first character
	MOV	b_read,%rdx	# count of characters
	SYSCALL

	MOV	b_read,%rdi
	JMP	theend

toobig:
	MOV	$write_64,%rax	# write function
	MOV	$stderr,%rdi	# file handle in RDI
	MOV	$toomsg,%rsi	# RSI points to toobig message
	MOV	toolen,%rdx	# bytes to be written
	SYSCALL
	MOV	$tooval,%rdi
	JMP	theend

error:
	MOV	$write_64,%rax	# write function
	MOV	$stderr,%rdi	# file handle in RDI
	MOV	$errmsg,%rsi	# RSI points to file error message
	MOV	errlen,%rdx	# bytes to be written
	SYSCALL
	MOV	$errval,%rdi

theend:
	MOV	$exit_64,%rax	# exit program function
	SYSCALL