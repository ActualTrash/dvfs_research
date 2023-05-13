.global write_zeros
.global write_ones
.global write_value
.global xmm_write_zeros
.global xmm_write_ones
.global xmm_write_value

write_zeros:
    mov $1000, %r10 # of registers to fill
    xor %r8, %r8
    vpxor %ymm1, %ymm1, %ymm1
write0:
    cmp %r10, %r8
    je  done0
    inc %r8
    vmovdqu %ymm1, %ymm0 
    vmovdqu %ymm1, %ymm0 
    vmovdqu %ymm1, %ymm0 
    vmovdqu %ymm1, %ymm0 
    vmovdqu %ymm1, %ymm0 
    vmovdqu %ymm1, %ymm0 
    vmovdqu %ymm1, %ymm0 
    vmovdqu %ymm1, %ymm0 
    vmovdqu %ymm1, %ymm0 
    vmovdqu %ymm1, %ymm0 
    vmovdqu %ymm1, %ymm0 
    vmovdqu %ymm1, %ymm0 
    vmovdqu %ymm1, %ymm0 
    vmovdqu %ymm1, %ymm0 
    vmovdqu %ymm1, %ymm0 
    jmp write0
done0:
    ret



write_ones:
    mov $1000, %r10 # of registers to fill
    xor %r8, %r8
    vpcmpeqd %ymm1, %ymm1, %ymm1
write1:
    cmp %r10, %r8
    je  done1
    inc %r8
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    jmp write1
done1:
    ret



# Arguments:
#   %rdi (long*) - 32 byte array of data to move into register
write_value:
    mov $1000, %r10 # of registers to fill
    xor %r8, %r8
    vmovdqu (%rdi), %ymm1
write2:
    cmp %r10, %r8
    je  done2
    inc %r8
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    vmovdqu %ymm1, %ymm0
    jmp write2
done2:
    ret



# -------------------------------------
# XMM varients
# -------------------------------------

xmm_write_zeros:
    mov $1000, %r10 # of registers to fill
    xor %r8, %r8
    vpxor %xmm1, %xmm1, %xmm1
write3:
    cmp %r10, %r8
    je  done3
    inc %r8
    vmovdqu %xmm1, %xmm0 
    vmovdqu %xmm1, %xmm0 
    vmovdqu %xmm1, %xmm0 
    vmovdqu %xmm1, %xmm0 
    vmovdqu %xmm1, %xmm0 
    vmovdqu %xmm1, %xmm0 
    vmovdqu %xmm1, %xmm0 
    vmovdqu %xmm1, %xmm0 
    vmovdqu %xmm1, %xmm0 
    vmovdqu %xmm1, %xmm0 
    vmovdqu %xmm1, %xmm0 
    vmovdqu %xmm1, %xmm0 
    vmovdqu %xmm1, %xmm0 
    vmovdqu %xmm1, %xmm0 
    vmovdqu %xmm1, %xmm0 
    jmp write3
done3:
    ret



xmm_write_ones:
    mov $1000, %r10 # of registers to fill
    xor %r8, %r8
    vpcmpeqd %xmm1, %xmm1, %xmm1
write4:
    cmp %r10, %r8
    je  done4
    inc %r8
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    jmp write4
done4:
    ret



# Arguments:
#   %rdi (long*) - 16 byte array of data to move into register
xmm_write_value:
    mov $1000, %r10 # of registers to fill
    xor %r8, %r8
    vmovdqu (%rdi), %xmm1
write5:
    cmp %r10, %r8
    je  done5
    inc %r8
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    vmovdqu %xmm1, %xmm0
    jmp write5
done5:
    ret
