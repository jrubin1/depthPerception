.data
.files:
.word 0 
lfsr:
	.align 4
	.word 0x1
.text
la t0 .files
main:
	li s0 20
main_random_loop:
	beq s0 x0 main_end
	# printf("%d", lfsr_random());
	jal lfsr_random
	mv a1 a0
	jal print_int
	# printf("\n");
	jal print_newline
	addi s0 s0 -1
	jal x0 main_random_loop
main_end:
	# exit()
	li a0 10
	ecall
# Helper functions (may be useful for debugging)
# You can assume these don't touch any registers except
# ra, a0, and a1.
print_int:
	li a0 1
	ecall
	jr ra
print_intx:
	li a0 34
	ecall
	jr ra
print_str:
	li a0 4
	ecall
	jr ra
print_space:
	li a1 ' '
	li a0 11
	ecall
	jr ra
print_newline:
	li a1 '\n'
	li a0 11
	ecall
	jr ra
# Implements a 16-bit lfsr
#
# Arguments: None
lfsr_random:
	la t0 lfsr
	lhu a0 0(t0)
	# Your Code Here
	# xor t1 t2
	# i = 0
	li t5 0
	li t6 16
	loop:
	beq t5 t6 exit
	# t1 = word >> 0
	srli t1 a0 0
	srli t2 a0 2
	srli t3 a0 3
	srli t4 a0 5
	xor t1 t1 t2
	xor t1 t1 t3
	xor t1 t1 t4
	# reg >> 1
	srli t2 a0 1
	# highest << 15
	slli t1 t1 15
	or a0 t2 t1
	slli a0 a0 16
	srli a0 a0 16
	# i++
	addi t5 t5 1
	j loop
	exit:
	la t0 lfsr
	sh a0 0(t0)
	jr ra
