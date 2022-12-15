; Trabajo integrador
;
; Created: 2/12/2022 17:13:06
; Author : Ezequiel Mundani

.include "m328Pdef.inc"

.def aux = r16
.def aux2 = r17
.def aux3 = r18
.def counter = r19
.def transmitChar = r20
.def topReached = r21

.dseg
.org SRAM_START
	readSign:	.byte	7 ;Acá se guarda el signo leído, con un \0 al final

.cseg
.org 0x0000
	rjmp start
.org OC1Aaddr
	rjmp handlerIntTimerTop
.org ICP1addr
	rjmp handlerIntCaptureEvent

.org INT_VECTORS_SIZE

start:
	ldi	aux, low(RAMEND)
	out	sph, aux
	ldi	aux, low(RAMEND)
	out	spl, aux 

	call configurePorts
	call configureUSART

	ldi	xh, high(readSign)
	ldi	xl, low (readSign)

	ldi counter, 0
	ldi topReached, 0

newCommunication:
	call configureTimer1ICU1
	sei

	loopEsperarFlanco1:
		cpi counter, 0
		breq loopEsperarFlanco1
		
	call configureTimer1ICU2

	loopEsperarFlanco2:
		cpi counter, 1
		breq loopEsperarFlanco2

	call configureTimer1CTC

	mainLoop:
		call noReadingLoop
		rjmp mainLoop

configurePorts:
	cbi DDRD, DDD0 ;configuro el pin RXD como entrada
	sbi DDRD, DDD1 ;configuro el pin TXD como salida
	cbi DDRB, 0    ;configuro el pin para capturar eventos

	ret

handlerIntCaptureEvent:
	in aux, SREG
	push aux

	inc counter

	retiHandlerIntCaptureEvent: 
	pop aux
	out SREG, aux
	reti

handlerIntTimerTop:
	in aux, SREG
	push aux

	ldi topReached, 1

	pop aux
	out SREG, aux
	reti

.include "timersConfiguration.asm"
.include "USART.asm"
.include "delays.asm"
.include "morseSubroutines.asm"
.include "morseMap.asm"
.include "morseRead.asm"
