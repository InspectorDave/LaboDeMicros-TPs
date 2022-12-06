; Trabajo integrador
;
; Created: 2/12/2022 17:13:06
; Author : Ezequiel Mundani

.include "m328Pdef.inc"

.def aux = r16
.def aux2 = r17
.def transmitChar = r18
.def counter = r19 
.def speed = r20

.dseg
.org SRAM_START
	readSign:	.byte	7 ;Acá se guarda el signo leído, con un \0 al final

.cseg
.org 0x0000
	rjmp start

.org INT_VECTORS_SIZE

start:	
	call configurePorts
	call configureUSART

	ldi	xh, high(readSign)
	ldi	xl, low (readSign)

	;;;; Hardcodeo la última secuencia Morse recibida
	ldi aux, '-'
	st x+, aux
	ldi aux, '-'
	st x+, aux
	ldi aux, '.'
	st x+, aux
	ldi aux, 0
	st x, aux
	
mainLoop:
	call identifyChar

	call transmitUsart

	call delay8Mcicles
	rjmp mainLoop

configurePorts:
	cbi DDRD, DDD0 ;configuro el pin RXD como entrada
	sbi DDRD, DDD1 ;configuro el pin TXD como salida
	cbi DDRD, DDD4 ;configuro el cuarto pin del puerto D como entrada (para el decodificador de audio)
	ret

.include "USART.asm"

delay8Mcicles: ;0,5s a 16MHz
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

.include "morseSubroutines.asm"
.include "morseMap.asm"
