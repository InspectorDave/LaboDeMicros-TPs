; ParteA.asm
;
; Created: 27/10/2022 03:40:05
; Author : Ezequiel Mundani Vegega

.include "m328pdef.inc"

.equ PIN_LED = 2

.cseg
.org 0x0000
	rjmp start

.org INT_VECTORS_SIZE

start:
	sbi DDRB, PIN_LED ;setea el pin dado de B como out
	blink: 
		sbi PORTB, PIN_LED ;prendo el pin de B
		call delay8Mcicles ;espero 1 segundo
		cbi PORTB, PIN_LED ;apago el pin de B
		call delay8Mcicles ;espero 1 segundo
		rjmp blink

delay8Mcicles:
	ldi r18, 41
	ldi r19, 150
	ldi r20, 125
	L1:
		dec r20
		brne L1
		dec r19
		brne L1
		dec r18
		brne L1
	nop
	ret
