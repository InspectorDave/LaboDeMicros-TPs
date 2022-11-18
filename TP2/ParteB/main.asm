; TP2.asm
;
; Created: 4/11/2022 22:04:56
; Author : Ezequiel Mundani Vegega

.include "m328Pdef.inc"
.include "7SegmentsDisplayDef.inc"

.def aux = r16
.def eepromAddress = r21
.def dispValue = r17 ;el valor que se mostrará
.equ lastValueAddress = 0x0C ;EEprom's address where the last value will be saved

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
	call cicleLetters

	ldi eepromAddress, lastValueAddress
	call eepromRead
	mov dispValue, aux

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

configure_int0: ;por flanco descendente
	lds  aux, EICRA
	ori  aux, (1 << ISC01)
	andi aux, ~( (1 << ISC00) )
	sts  EICRA, aux
	ret

configure_int1: ;por flanco descendente
	lds  aux, EICRA
	ori  aux, (1 << ISC11)
	andi aux, ~( (1 << ISC10) )
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
	call delay16kcicles ;compruebo que no haya sido un error
	in aux, PIND
	andi aux, 0b00000100
	cpi aux, 0b00000000
	brne reti1
	
	cpi dispValue, 0xF ;compruebo que pueda seguir incrementando
	breq reti0
	
	inc dispValue
	call displayValue
	mov aux, dispValue
	ldi eepromAddress,lastValueAddress
	call eepromWrite
	reti0: reti

handlerIntExt1:
	call delay16kcicles ;compruebo que no haya sido un error
	in aux, PIND
	andi aux, 0b00001000
	cpi aux, 0b00000000
	brne reti1

	cpi dispValue, 0x0 ;compruebo que pueda seguir incrementando
	breq reti1

	dec dispValue
	call displayValue
	mov aux, dispValue
	ldi eepromAddress,lastValueAddress
	call eepromWrite
	reti1: reti

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

delay16kcicles: ;1ms a 16MHz
	ldi r18, 9
	ldi r19, 30
	ldi r20, 226
	L2:
		dec r20
		brne L2
		dec r19
		brne L2
		dec r18
		brne L2
	nop
	nop
	ret

.include "EEpromReadWriteSubroutines.asm"
.include "DisplaySubroutines.asm"
