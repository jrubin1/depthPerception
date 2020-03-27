.text

# Decodes a quadtree to the original matrix
#
# Arguments:
#     quadtree (qNode*)
#     matrix (void*)
#     matrix_width (int)
#
# Recall that quadtree representation uses the following format:
#     struct qNode {
#         int leaf;
#         int size;
#         int x;
#         int y;
#         int gray_value;
#         qNode *child_NW, *child_NE, *child_SE, *child_SW;
#     }

quad2matrix:
	# Your code here
	# structs tightly packed and I am assuming they go in order downwards, 
	# each spaced out by 4
	# a0 
	# a1 
	# a2

	# approach
	# loop through each index in matrix 
	# find that item in quadtree
	# 	by 
	# 	start from qnode 
	# 	if leaf and pixel in range:
	# 		fill with color
	# 	else if not leaf and pixel in range 
	# 		look for child node whose range holds pixel
	# 		check x and y of pixel > x and y of node 
	# 		and x and y pf pixel < x and y of node plus size 

	# recursive approach
	# input qnode 
	# 	if leaf 
	# 		populate corresponding matrix pixels
	# 	else call func on children 
	lw t1 0(a0)
	addi t2 x0 1
	# if not leaf skip base case
	bne t1 t2 continue
	# t1 = x
	lw t1 8(a0)	#currX = x

	lw t2 12(a0) #y

	lw t3 16(a0) #grey value

	lw t4 4(a0) #size

	add t5 t4 t1 #x + size

	add t6 t4 t2 #y + size

	loopX:
		# # t3 = x
		# lw t3 8(a0) #load x
		# # t4 = size
		# lw t4 4(a0) #load size
		# # t3 = size + x
		# add t3 t3 t4 #maxX = x + size
		# # if currX >= size + x: exit loop
		# bge t1 t3 exit1 #if currX >= maxX: exit1

		bge t1 t5 exit1

		# t2 = y
		lw t2 12(a0) #currY = y

		loopY:
			# # t3 = y
			# lw t3 12(a0) #load y
			# # t4 = size
			# lw t4 4(a0) #load size
			# # t3 = y + size
			# add t3 t3 t4 #maxY = y + size
			# # if currY >= size + y: exit loop
			# bge t2 t3 exit2 #if currY >= maxY: exit2
			# # y * map_width + x
			# mul t3 t2 a2 #temp = currY * matrix_width
			# add t3 t3 t1 #temp = temp + currX
			# # t3 now holds mapped_index
			# # matrix[mapped_index (t3)] = 16(a0)
			# # t4 = 4
			# li t4 4 #load 4
			# # t4 = mappex_index * 4
			# mul t4 t4 t3 #adjustedIndex = 4 * currY * matrix_width + currX
			# # t5 = grey_value
			# lw t5 16(a0) #load grey_value
			# # t4 = add offset of t4 mapped_index to matrix address 
			# add t4 t4 a1 #matrix[adjustedIndex]
			# # matrix[mapped_index] = grey_value
			# sb t5 0(t4) #matrix[adjustedIndex] = grey_value
			# # t2++
			bge t2 t6 exit2

			mul t0 t2 a2 #y * matrix_width
			add t0 t0 t1 # y * matrix_width + x
			

			li t4 1
			mul t0 t0 t4 #matrix_index * 4

			add t0 t0 a1 #matrix + matrix_index * 4

			sb t3 0(t0)

			addi t2 t2 1 #currY++

			j loopY
		exit2:
		# t1++
		addi t1 t1 1 #currX++

		j loopX
	exit1:
	j end
	continue:
	# a0 = a0.child_NW
	# might be bug here with a0 and recursion
	addi sp sp -8
	sw ra 0(sp)
	sw a0 4(sp)
	lw a0 20(a0)
	jal quad2matrix
	lw ra 0(sp)
	lw a0 4(sp)
	addi sp sp 8

	addi sp sp -8
	sw ra 0(sp)
	sw a0 4(sp)
	lw a0 24(a0)
	jal quad2matrix
	lw ra 0(sp)
	lw a0 4(sp)
	addi sp sp 8

	addi sp sp -8
	sw ra 0(sp)
	sw a0 4(sp)
	lw a0 28(a0)
	jal quad2matrix
	lw ra 0(sp)
	lw a0 4(sp)
	addi sp sp 8

	addi sp sp -8
	sw ra 0(sp)
	sw a0 4(sp)
	lw a0 32(a0)
	jal quad2matrix
	lw ra 0(sp)
	lw a0 4(sp)
	addi sp sp 8
	end:


	jr ra

