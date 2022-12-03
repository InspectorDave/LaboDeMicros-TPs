; Trabajo integrador
;
; Created: 2/12/2022 17:13:06
; Author : Ezequiel Mundani

.include "m328Pdef.inc"

.def aux = r16
.def aux2 = r17
.def transmitChar = r18

.dseg
.org SRAM_START
	readSign:	.byte	6 ;Acá se guarda el signo leído, con un \0 al final

.cseg
.org 0x0000
	rjmp start

.org INT_VECTORS_SIZE

start:	
	call configurePorts



	call identifyChar
	call transmitUsart

	rjmp start

configurePorts:
	cbi DDRD, DDD0 ;configuro el pin RXD como entrada
	sbi DDRD, DDD1 ;configuro el pin TXD como salida
	cbi DDRD, DDD4 ;configuro el cuarto pin del puerto D como entrada (para el decodificador de audio)
	ret

.include "USART.asm"

identifyChar:
		ldi	xh, high(readSign)
		ldi	xl, low (readSign)
		ldi	zh, high(MORSE_A)
		ldi	zl, low (MORSE_A)
	loopA:
		ld aux, x+
		ld aux2, z+
		cp aux, aux2
		brne charB
		cpi aux, '0'
		breq loopA
		ldi transmitChar, 'A'
		ret
	charB:
		ldi	xh, high(readSign)
		ldi	xl, low (readSign)
		ldi	zh, high(MORSE_B)
		ldi	zl, low (MORSE_B)
	loopB:
		ld aux, x+
		ld aux2, z+
		cp aux, aux2
		brne charC
		cpi aux, '0'
		breq loopB
		ldi transmitChar, 'B'
		ret
	charC:
		ldi	xh, high(readSign)
		ldi	xl, low (readSign)
		ldi	zh, high(MORSE_C)
		ldi	zl, low (MORSE_C)
	loopC:
		ld aux, x+
		ld aux2, z+
		cp aux, aux2
		brne charD
		cpi aux, '0'
		breq loopC
		ldi transmitChar, 'B'
		ret
	charD:
		nop

MORSE_A: .db ".-", 0
MORSE_B: .db "-...", 0
MORSE_C: .db "-.-.", 0
MORSE_D: .db "-..", 0
MORSE_E: .db ".", 0
MORSE_F: .db "..-.", 0
MORSE_G: .db "--.", 0
MORSE_H: .db "....", 0
MORSE_I: .db "..", 0
MORSE_J: .db ".---", 0
MORSE_K: .db "-.-", 0
MORSE_L: .db ".-..", 0
MORSE_M: .db "--", 0
MORSE_N: .db "-.", 0
MORSE_O: .db "---", 0
MORSE_P: .db ".--.", 0 
MORSE_Q: .db "--.-", 0 
MORSE_R: .db ".-.", 0 
MORSE_S: .db "...", 0 
MORSE_T: .db "-", 0 
MORSE_U: .db "..-", 0 
MORSE_V: .db "...-", 0 
MORSE_W: .db ".--", 0 
MORSE_X: .db "-..-", 0 
MORSE_Y: .db "-.--", 0 
MORSE_Z: .db "--..", 0 
MORSE_0: .db "-----", 0
MORSE_1: .db ".----", 0 
MORSE_2: .db "..---", 0 
MORSE_3: .db "...--", 0 
MORSE_4: .db "....-", 0 
MORSE_5: .db ".....", 0 
MORSE_6: .db "-....", 0 
MORSE_7: .db "--...", 0 
MORSE_8: .db "---..", 0 
MORSE_9: .db "----.", 0 
MORSE_DOT: .db ".-.-.-", 0 
MORSE_COMMA: .db "--..--", 0 
MORSE_QMRK: .db "..--..", 0 
MORSE_QUOTES: .db ".-..-.", 0 
MORSE_SLASH: .db "-..-.", 0