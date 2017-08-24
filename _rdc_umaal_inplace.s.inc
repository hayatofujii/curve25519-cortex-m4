@.syntax unified
@.global _fe_rdc_umaal_inplace
@.type _fe_rdc_umaal_inplace,function
@_fe_rdc_umaal_inplace:
    @PUSH {r4-r12, r14}

    @LDM r0, {r1-r11}
    LDM sp, {r1-r11}
	MOV r12, #0
	MOV r14, #38

    UMLAL r1, r12,  r9, r14
    UMAAL r2, r12, r10, r14
    UMAAL r3, r12, r11, r14

    @LDR  r9, [r0, #4*11]
    @LDR r10, [r0, #4*12]
    @LDR r11, [r0, #4*13]
    LDR  r9, [sp, #4*11]
    LDR r10, [sp, #4*12]
    LDR r11, [sp, #4*13]
    UMAAL r4, r12,  r9, r14

    UMAAL r5, r12, r10, r14
    UMAAL r6, r12, r11, r14

    @LDR  r9, [r0, #4*14]
    @LDR r10, [r0, #4*15]
    LDR  r9, [sp, #4*14]
    LDR r10, [sp, #4*15]
    UMAAL r7, r12,  r9, r14
    UMAAL r8, r12, r10, r14

    MOV r11, #0
    UMLAL r1, r11, r12, r14
    ADDS r2, r2, r11
    ADCS r3, r3, #0
	ADCS r4, r4, #0
    ADCS r5, r5, #0
    ADCS r6, r6, #0
    ADCS r7, r7, #0
    ADCS r8, r8, #0
    MOV r12, #0
    ADC r12, r12, #0

    UMLAL r2, r11, r12, r14

    STM r0, {r1-r8}

    ADD sp, sp, #(4*16)
    POP {r4-r12, pc}
