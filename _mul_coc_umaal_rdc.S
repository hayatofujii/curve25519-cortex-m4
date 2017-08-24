.syntax unified
.global _fe_mul_coc_umaal_rdc
.type _fe_mul_coc_umaal_rdc,function

_fe_mul_coc_umaal_rdc:
	PUSH {r4-r12, r14}

	SUB sp, #(4*16)

	@ C	  sp
	@ A	  r1
	@ B	  r2
	@ COMBA  r3  r4  r5
	@ Alimbs r6  r7  r8
	@ Blimbs r9 r10 r11
	@ carry  r12 r14

	/* **** B_top ***** */

	@ LOAD AREA
	LDR r6, [r1, #(4*6)] @ A6
	LDR r7, [r1, #(4*7)] @ A7
	LDR r9, [r2, #(4*0)] @ B0
	LDR r10, [r2, #(4*1)] @ B1
	LDR r11, [r2, #(4*2)] @ B2

	@ C6
	UMULL r3, r4, r6, r9 @ A6 B0
		MOV r5, #0
		MOV r12, #0

	@ C7
	UMLAL r4, r5, r7, r9 @ A7 B0
		STR r3, [sp, #(4*6)]

	UMLAL r4, r12, r6, r10 @ A6 B1

	@ C8
	UMAAL r5, r12, r7, r10 @ A7 B1
		LDR r6, [r1, #(4*0)] @ A0
		LDR r7, [r1, #(4*1)] @ A1
		LDR r8, [r1, #(4*2)] @ A2
		STR r4, [sp, #(4*7)]

	/* ***** r0 ***** */

	@ C0
	UMULL r3, r4, r6, r9 @ A0 B0
		STR r5, [sp, #(4*8)]
		MOV r5, #0
		STR r12, [sp, #(4*9)]

	@ C1
	UMLAL r4, r5, r7, r9 @ A1 B0
		STR r3, [sp, #(4*0)]
		MOV r3, #0

	UMLAL r4, r3, r6, r10 @ A0 B1

	@ C2
	UMAAL r5, r3, r8, r9 @ A2 B0
		STR r4, [sp, #(4*1)]
		MOV r4, #0
		MOV r12, #0

	UMLAL r5, r12, r7, r10 @ A1 B1

	UMLAL r5, r4, r6, r11 @ A0 B2

	@ C3
	UMAAL r3, r4, r8, r10 @ A2 B1
		STR r5, [sp, #(4*2)]
		MOV r5, #0

	UMAAL r3, r12, r7, r11 @ A1 B2
		LDR r9, [r2, #(4*3)] @ B3
		LDR r10, [r2, #(4*4)] @ B4

	UMLAL r3, r5, r6, r9 @ A0 B3

	@ C4
	UMAAL r4, r5, r8, r11 @ A2 B2
		STR r3, [sp, #(4*3)]
		MOV r3, #0

	UMAAL r4, r12, r7, r9 @ A1 B3

	UMLAL r4, r3, r6, r10 @ A0 B4

	@ C5
	UMAAL r5, r3, r8, r9  @ A2 B3
		STR r4, [sp, #(4*4)]
		MOV r4, #0

	UMAAL r5, r12, r7, r10 @ A1 B4

	@ LOAD AREA
	LDR r9, [r2, #(4*6)] @ B6
	LDR r11, [r2, #(4*5)] @ B5
	LDR r14, [sp, #(4*6)] @ C6

	UMLAL r5, r4, r6, r11 @ A0 B5

	@ C6
	UMAAL r3, r4, r8, r10 @ A2 B4
		STR r5, [sp, #(4*5)]

	UMAAL r3, r12, r7, r11 @ A1 B5

	UMAAL r3, r14, r6, r9 @ A0 B6
		LDR r10, [r2, #(4*7)] @ B7
		LDR r5, [sp, #(4*7)] @ C7

	@ C7
	UMAAL r4, r5, r8, r11 @ A2 B5
		STR r3, [sp, #(4*6)]

	UMAAL r4, r12, r7, r9 @ A1 B6

	UMAAL r4, r14, r6, r10 @ A0 B7
		LDR r6, [r1, #(4*3)] @ A3
		LDR r3, [sp, #(4*8)] @ C8

	@ C8
	UMAAL r5, r3, r6, r11 @ A3 B5
		STR r4, [sp, #(4*7)]

	UMAAL r5, r12, r8, r9 @ A2 B6

	UMAAL r5, r14, r7, r10 @ A1 B7
		LDR r7, [r1, #(4*4)] @ A4
		LDR r4, [sp, #(4*9)] @ C9

	@ C9
	UMAAL r3, r4, r7, r11 @ A4 B5
		STR r5, [sp, #(4*8)]

	UMAAL r3, r12, r6, r9 @ A3 B6

	UMAAL r3, r14, r8, r10 @ A2 B7

	@ C10
	UMAAL r4, r12, r7, r9 @ A4 B6
		STR r3, [sp, #(4*9)]

	UMAAL r4, r14, r6, r10 @ A3 B7

	@ C11
	UMAAL r12, r14, r7, r10 @ A4 B7
		STR r4, [sp, #(4*10)]

	STR r12, [sp, #(4*11)]
	@ STR r14, [sp, #(4*12)] is below
	@ pipelining (:

	/* ***** r1 ***** */

	@ LOAD AREA
	LDR	r8, [r1, #(4*5)] @ A5
	LDR r9, [r2, #(4*0)] @ B0
	LDR r10, [r2, #(4*1)] @ B1
	LDR r11, [r2, #(4*2)] @ B2

	LDR r3,  [sp, #(4*3)] @ C3
	LDR r4,  [sp, #(4*4)] @ C4
	LDR r5,  [sp, #(4*5)] @ C5

	STR r14, [sp, #(4*12)] @ C12

	@ C3
	MOV r12, #0
	UMLAL r3, r12, r6, r9 @ A3 B0

	@ C4
	UMAAL r4, r12, r7, r9 @ A4 B0
		STR r3, [sp, #(4*3)]
		MOV r3, #0

	UMLAL r4, r3, r6, r10 @ A3 B1

	@ C5
	UMAAL r5, r3, r8, r9 @ A5 B0
		STR r4, [sp, #(4*4)]
		MOV r4, #0

	UMAAL r5, r12, r7, r10 @ A4 B1

	UMLAL r5, r4, r6, r11 @ A3 B2

	@ C6
	UMAAL r3, r4, r8, r10 @ A5 B1
		STR r5, [sp, #(4*5)]
		LDR r9,  [r2, #(4*3)] @ B3
		LDR r5,  [sp, #(4*6)] @ C6

	UMAAL r3, r12, r7, r11 @ A4 B2

	UMAAL r3, r5, r6, r9 @ A3 B3

	@ C7
	UMAAL r4, r5, r8, r11 @ A5 B2
		STR r3, [sp, #(4*6)]
		LDR r10, [r2, #(4*4)] @ B4
		LDR r3, [sp, #(4*7)] @ C7

	UMAAL r4, r12, r7, r9 @ A4 B3

	UMAAL r4, r3, r6, r10 @ A3 B4
		LDR r6,  [r1, #(4*6)] @ A6
		LDR r10, [r2, #(4*4)] @ B4

	@ C8
	UMAAL r5, r3, r6, r11 @ A6 B2
		STR r4, [sp, #(4*7)]
		LDR r4, [sp, #(4*8)] @ C8

	UMAAL r5, r12, r8, r9 @ A5 B3

	UMAAL r5, r4, r7, r10 @ A4 B4
		LDR r7, [r1, #(4*7)] @ A7

	@ C9
	UMAAL r3, r4, r7, r11 @ A7 B2
		STR r5,  [sp, #(4*8)]
		LDR r11, [r2, #(4*5)] @ B5
		LDR r5,  [sp, #(4*9)] @ C9

	UMAAL r3, r12, r6, r9 @ A6 B3

	UMAAL r3, r5, r8, r10 @ A5 B4

	@ C10
	UMAAL r4, r5, r7, r9 @ A7 B3
		STR r3, [sp, #(4*9)]
		LDR r9, [r2, #(4*6)] @ B6
		LDR r3, [sp, #(4*10)] @ C10

	UMAAL r4, r12, r6, r10 @ A6 B4

	UMAAL r4, r3, r8, r11 @ A5 B5

	@ C11
	UMAAL r5, r3, r7, r10 @ A7 B4
		STR r4, [sp, #(4*10)]
		LDR r10, [r2, #(4*7)] @ B7
		LDR r4, [sp, #(4*11)] @ C11

	UMAAL r5, r12, r6, r11 @ A6 B5

	UMAAL r5, r4, r8, r9 @ A5 B6

	@ C12
	UMAAL r3, r4, r7, r11 @ A7 B5
		STR r5, [sp, #(4*11)]
		LDR r5, [sp, #(4*12)] @ C12

	UMAAL r3, r12, r6, r9 @ A6 B6

	UMAAL r3, r5, r8, r10 @ A5 B7

	@ C13
	UMAAL r4, r5, r7, r9 @ A7 B6
		STR r3, [sp, #(4*12)]

	UMAAL r4, r12, r6, r10 @ A6 B7

	@ C14
	UMAAL r5, r12, r7, r10 @ A7 B7
		STR r4, [sp, #(4*13)]

	STR r5, [sp, #(4*14)]

	@ C15
	STR r12, [sp, #(4*15)]

#include "_rdc_umaal_inplace.s.inc"
