.data

lfsr:
	.align 4
	.word 0x1

.text

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
