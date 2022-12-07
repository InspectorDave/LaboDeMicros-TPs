; TP4B
;
; Created: 1/12/2022 21:47:06
; Author : Ezequiel Mundani

.include "m328Pdef.inc"

.def aux = r16
.def aux2 = r17
.def transmitChar = r18

.cseg
.org 0x0000
	rjmp start

.org INT_VECTORS_SIZE

start:
    call configurePorts
	call configureUSART
	call sendWelcomeMessage
	call delay8Mcicles
	
loop:
	call receiveUSART
	call turnOnLED
	rjmp loop

configurePorts:
	cbi DDRD, DDD0 ;configuro el pin RXD como entrada
	sbi DDRD, DDD1 ;configuro el pin TXD como salida

	in aux, DDRD ;configuro el último nibble del puerto D como salida (para los LEDs)
	ori aux, 0b11110000
	out DDRD, aux
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
	;Compruebo que pueda enviar un nuevo byte
	lds aux, UCSR0A
	sbrs aux, UDRE0
	rjmp transmitUSART

	sts UDR0, transmitChar
	ret

receiveUSART:
	;Cpmpruebo que pueda recibir un nuevo byte
	lds aux, UCSR0A	andi aux, 1<<RXC0
	sbrs aux, RXC0
	rjmp receiveUSART

	lds transmitChar, UDR0
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

turnOnLED:
	display1:
		cpi transmitChar, '1'
		brne display2
		ldi aux2, 0b00010000
		rjmp retOk
	display2:
		cpi transmitChar, '2'
		brne display3
		ldi aux2, 0b00100000
		rjmp retOk
	display3:
		cpi transmitChar, '3'
		brne display4
		ldi aux2, 0b01000000
		rjmp retOk
	display4:
		cpi transmitChar, '4'
		brne retErr
		ldi aux2, 0b10000000
	retOk:
		in aux, PORTD
		eor aux, aux2
		out PORTD, aux
	retErr:
		ret

;13 = \r, 10 = \n, 0 = \0
frase: .db "*** Hola Labo de Micro ***", 13, 10, "Escriba 1, 2, 3 o 4 para controlar los LEDs", 13, 10, 0