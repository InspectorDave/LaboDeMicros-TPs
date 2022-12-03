; Trabajo integrador
;
; Created: 2/12/2022 17:13:06
; Author : Ezequiel Mundani

.include "m328Pdef.inc"

.def aux = r16
.def aux2 = r17
.def transmitChar = r18
.def counter = r19 

.dseg
.org SRAM_START
	readSign:	.byte	7 ;Ac� se guarda el signo le�do, con un \0 al final

.cseg
.org 0x0000
	rjmp start

.org INT_VECTORS_SIZE

start:	
	call configurePorts
	
	ldi	xh, high(readSign)
	ldi	xl, low (readSign)

	ldi aux, '.'
	st x+, aux
	ldi aux, '.'
	st x+, aux
	ldi aux, '-'
	st x+, aux
	ldi aux, '-'
	st x+, aux
	ldi aux, '.'
	st x+, aux
	ldi aux, '.'
	st x+, aux
	ldi aux, 0
	st x, aux
	
mainLoop:
	call identifyChar

	call transmitUsart

	rjmp mainLoop

configurePorts:
	cbi DDRD, DDD0 ;configuro el pin RXD como entrada
	sbi DDRD, DDD1 ;configuro el pin TXD como salida
	cbi DDRD, DDD4 ;configuro el cuarto pin del puerto D como entrada (para el decodificador de audio)
	ret

.include "USART.asm"

identifyChar:
	ldi	xh, high(readSign)
	ldi	xl, low (readSign)
	ldi	zh, high(morseChars*2)
	ldi	zl, low (morseChars*2)
	ldi counter, 0

	loop1:
		ld aux, x+
		lpm aux2, z
		cp aux, aux2
		brne goToNextSign
		lpm aux2, z+   ;Uso esto solo para incrementar z+
		cpi aux, 0
		breq matchSignWithChar
		rjmp loop1



goToNextSign:
	lpm aux2, z+
	cpi aux2, 0
	brne goToNextSign

	inc counter
	ldi	xh, high(readSign)
	ldi	xl, low (readSign)

	rjmp loop1

matchSignWithChar:
	cpi counter, 26 ;Veo si es una de las letras
	brlo itsLetter
	cpi counter, 36 ;Veo si es uno de los n�meros
	brlo itsNumber
	rjmp itsSign    ;No es ni letra ni n�mero, debe ser signo de puntuaci�n

itsLetter:
	ldi transmitChar, 65      ;La posici�n de la A en ASCII
	add transmitChar, counter ;En base al valor del contador s� qu� letra es
	ret

itsNumber:
	ldi transmitChar, 22       ;La posici�n del 0 en ASCII (48) menos las 26 posiciones del contador que no son n�meros
	add transmitChar, counter  ;Dado a que ya rest� 26, al sumar el contador s� qu� n�mero es
	ret

itsSign:
	;No se pueden ordenar los signos en mi mapa Morse igual que en la tabla ASCII, hago if-else
	cpi counter, 36
	brne comma
	ldi transmitChar, 46
	ret
	comma:
	cpi counter, 37
	brne questionMark
	ldi transmitChar, 44	
	ret
	questionMark:
	cpi counter, 38
	brne quotes
	ldi transmitChar, 63	
	ret
	quotes:
	cpi counter, 39
	brne backslash
	ldi transmitChar, 34	
	ret
	backSlash:
	ldi transmitChar, 92	
	ret

morseChars: .db ".-", 0, "-...", 0, "-.-.", 0, "-..", 0, ".", 0, "..-.", 0, "--.", 0, "....", 0, "..", 0,\
	".---", 0, "-.-", 0, ".-..", 0, "--", 0, "-.", 0, "---", 0, ".--.", 0 , "--.-", 0, ".-.", 0, "...", 0,\
	"-", 0, "..-", 0, "...-", 0, ".--", 0, "-..-", 0, "-.--", 0, "--..", 0, "-----", 0, ".----", 0,\
	"..---", 0, "...--", 0, "....-", 0, ".....", 0, "-....", 0, "--...", 0, "---..", 0, "----.", 0,\
	".-.-.-", 0, "--..--", 0, "..--..", 0, ".-..-.", 0, "-..-.", 0
	; A B C D E F G H I
	; J K L M N O P Q R S
	; T U V W X Y Z 0 1
	; 2 3 4 5 6 7 8 9 
	; . , ? " \