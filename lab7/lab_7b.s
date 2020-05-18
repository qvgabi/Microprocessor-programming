#----------------------------------------------------------------
# Funkcja do programu lab_7b - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------

	.text
	.type sum3a, @function
	.globl sum3a	

sum3a:	
	mov %edi, %eax		# 1st parameter to %rax
	add %esi, %eax		# add 2nd parameter
	add %edx, %eax		# add 3rd parameter

	ret			# return sum