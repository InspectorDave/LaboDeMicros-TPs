; TP2.asm
;
; Created: 4/11/2022 22:04:56
; Author : Ezequiel Mundani Vegega

.include "m328Pdef.inc"
.include "7SegmentsDisplayDef.inc"

.def aux = r16
.def eepromAddress = r21
.def dispValue = r17 ;El valor que se mostrar�

.cseg
.org 0x0000
	rjmp start
.org INT0addr
	rjmp handlerIntExt0
.org INT1addr
	rjmp handlerIntExt1

.org INT_VECTORS_SIZE

start:
	cli
	rcall configure_ports
	rcall configure_int0
	rcall configure_int1
	rcall enable_int0
	rcall enable_int1

	call writeLettersInEEprom
	call cicleSegments

	ldi dispValue,0
	call displayValue

	sei

	main_loop:
		sleep
		rjmp  main_loop

configure_ports:
	ldi aux, 0xFF
	out DDRB, aux  ;configuro puerto B como out
	out DDRC, aux  ;configuro puerto C como out
	cbi DDRD, DDD2 ;configuro los pines del puerto D como in
	cbi DDRD, DDD3
	sbi PORTD, DDD2  ;prendo las resistencias de pull-up de los pines del pureto D
	sbi PORTD, DDD3 
	ret

configure_int0: ;por flanco ascendente
	lds  aux, EICRA
	ori  aux, (1 << ISC00) | (1 << ISC01)
	sts  EICRA, aux
	ret

configure_int1: ;por flanco ascendente
	lds  aux, EICRA
	ori  aux, (1 << ISC10) | (1 << ISC11)
	sts  EICRA, aux
	ret

enable_int0:
	in aux, EIMSK
	ori aux, (1<<INT0)
	out EIMSK, aux
	ret

enable_int1:
	in aux, EIMSK
	ori aux, (1<<INT1)
	out EIMSK, aux
	ret

handlerIntExt0:
	cpi dispValue, 0xF
	breq reti0
	inc dispValue
	call displayValue
	call delay8Mcicles ;Espero medio segundo para evitar considerar rebotes del bot�n
	reti0: reti

handlerIntExt1:
	cpi dispValue, 0x0
	breq reti1
	dec dispValue
	call displayValue
	call delay8Mcicles ;Espero medio segundo para evitar considerar rebotes del bot�n
	reti1: reti

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

.include "EEpromReadWriteSubroutines.asm"
.include "DisplaySubroutines.asm"
