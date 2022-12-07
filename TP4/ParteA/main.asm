; TP4A
;
; Created: 30/11/2022 21:47:06
; Author : Ezequiel Mundani

.include "m328Pdef.inc"

.def aux = r16
.def transmitChar = r17

.cseg
.org 0x0000
	rjmp start

.org INT_VECTORS_SIZE

start:
    call configurePorts
	call configureUSART
	call sendWelcomeMessage
	
	call delay8Mcicles
	rjmp start

configurePorts:
	cbi DDRD, DDD0 ;configuro el pin RXD como entrada
	sbi DDRD, DDD1 ;configuro el pin TXD como salida
	ret

configureUSART:
	;Baude rate
	ldi aux, 103
	sts UBRR0L, aux
	ldi aux, 0
	sts UBRR0H, aux

	;Status register B de la USART
	clr aux
	ldi aux, (0<<TXB80 | (0<<UCSZ02 | 1<<TXEN0)) | ((1<<RXEN0 | 0<<UDRIE0) | (0<<TXCIE0 | 0<<RXCIE0))
	sts UCSR0B, aux

	;Status register C de la USART
	clr aux
	ldi aux, ((0<<UCPOL0 | 1<<UCSZ00) | (1<<UCSZ01 | 0<<USBS0)) | ((0<<UPM00 | 0<<UPM01) | (0<<UMSEL00 | 0<<UMSEL01))
	sts UCSR0C, aux

	ret

transmitUSART:
	;compruebo que pueda enviar un nuevo byte
	lds aux, UCSR0A
	andi aux, 1<<UDRE0
	sbrs aux, UDRE0
	rjmp transmitUSART

	sts UDR0, transmitChar
	ret

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
	
sendWelcomeMessage:
	ldi	zl, low(2*frase)
	ldi	zh, high(2*frase)

	loop1:
		lpm	transmitChar, z+
		cpi transmitChar, 0
		breq ret1
		call transmitUSART
		rjmp loop1

	ret1:
		ret

;13 = \r, 10 = \n, 0 = \0
frase: .db "*** Hola Labo de Micro ***", 13, 10, "Escriba 1, 2, 3 o 4 para controlar los LEDs", 13, 10, 0