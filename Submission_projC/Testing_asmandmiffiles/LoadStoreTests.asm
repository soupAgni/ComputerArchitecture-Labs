                lb	$s0, 0($zero)		# 38.a: lb	$s0 = -1
                nop
                nop
                nop
                nop
		lb	$s1, 1($zero)		# 38,b: lb	$s1 = 4
		nop
                nop
                nop
                nop
                
		lbu	$s2, 2($zero)		# 39,a: lbu	$s2 = 8
		 nop
                nop
                nop
                nop
		lbu	$s3, 3($zero)		# 39.b: lbu	$s3 = 252
		                nop
                nop
                nop
                nop
		lh	$s4, 0($s1)		# 40: lh	$s4 = -256
		                nop
                nop
                nop
                nop
		lhu	$s5, 2($s1)		# 41: lhu	$s5 = 43690
		                nop
                nop
                nop
                nop
		lw	$s6, 0($s2)		# 42: lw	$s6 = 1729
		                nop
                nop
                nop
                nop
		sb	$s0, 3($s2)		# 43.a: sb	Store with byteena = 1000
		                nop
                nop
                nop
                nop
		sb	$s1, 2($s2)		# 43.b: sb	Store with byteena = 0100
		                nop
                nop
                nop
                nop
		sb	$s2, 1($s2)		# 43.c: sb	Store with byteena = 0010
		                nop
                nop
                nop
                nop
		sb	$s3, 0($s2)		# 43.d: sb	mem[2] = -16512772
		                nop
                nop
                nop
                nop
		sh	$s4, 2($s1)		# 44,a:	sh	Store with byteena = 1100
		                nop
                nop
                nop
                nop
		sh	$s5, 0($s1)		# 44.b: sh	mem[1] = -16733526
		                nop
                nop
                nop
                nop
		sw	$s6, 0($zero)		# 45: sw	mem[0] = 1729
		