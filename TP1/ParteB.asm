; ParteB.asm

; Created: 4/11/2022 15:55:37
; Author : Ezequiel Mundani Vegega

.include "m328pdef.inc"

.equ PIN_ON = 0
.equ PIN_OFF = 1
.equ PIN_LED = 2

.cseg
.org 0x0000
	rjmp start

.org INT_VECTORS_SIZE

start:
	sbi DDRB, PIN_LED ;setea el pin dado de B como out
	cbi DDRB, PIN_ON ;setea el pin dado de B como in
	cbi DDRB, PIN_OFF ;setea el pin dado de B como in

	loopOff:
		in r17, PINB
		andi r17, 0b00000001
		cpi r17, 0b00000001
		breq loopOn
		rjmp loopOff

	loopOn:
		call blink
		in r17, PINB
		andi r17, 0b00000010
		cpi r17, 0b00000010
		breq loopOff
		rjmp loopOn

blink: 
	sbi PORTB, PIN_LED ;prendo el pin de B
	call delay8Mcicles ;espero 1 segundo
	cbi PORTB, PIN_LED ;apago el pin de B
	call delay8Mcicles ;espero 1 segundo
	ret

delay8Mcicles:
	ldi r18, 1 ;41
	ldi r19, 150
	ldi r20, 1 ;125
	L1:
		dec r20
		brne L1
		dec r19
		brne L1
		dec r18
		brne L1
	nop
	ret