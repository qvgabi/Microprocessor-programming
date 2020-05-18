#----------------------------------------------------------------
# Funkcja do programu lab_9a - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------

	.text
	.type facta, @function
	.globl facta	

facta:	mov $1, %eax	# result or multiplicand

next:	cmp $1, %edi	# k <= 1 ?
	jbe f_e		# yes, so jump
	mul %edi	# result * k
	dec %edi	# k--
	jmp next

f_e:	ret
