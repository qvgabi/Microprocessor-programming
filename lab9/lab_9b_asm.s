#----------------------------------------------------------------
# Funkcja do programu lab_9b - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------

	.type fiba, @function
	.global fiba

fiba:	push %rbx	# store on stack

	mov $0, %ebx	# old
	mov $1, %ecx	# new

	cmp %ebx, %edi	# k == 0 ?
	jz	f_0	# yes, so jump
	cmp %ecx, %edi	# k == 1 ?
	jz	f_1	# yes, so jump

next:
	mov %ebx, %eax	# sum = old
	add %ecx, %eax	# sum += new
	mov %ecx, %ebx	# old = new
	mov %eax, %ecx	# new = sum
	dec %edi	# k--
	cmp $1, %edi	# k > 1 ?
	ja next		# yes, so jump

f_e:	pop %rbx	# restore original
	ret

f_0:
	mov %ebx, %eax	# return 0
	jmp f_e

f_1:
	mov %ecx, %eax	# return 1
	jmp f_e
