/*
 * morseSubroutines.asm
 *
 *  Created: 6/12/2022 05:07:02
 *   Author: ezequ
 */ 

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
	cpi counter, 36 ;Veo si es uno de los números
	brlo itsNumber
	rjmp itsSign    ;No es ni letra ni número, debe ser signo de puntuación

itsLetter:
	ldi transmitChar, 65      ;La posición de la A en ASCII
	add transmitChar, counter ;En base al valor del contador sé qué letra es
	ret

itsNumber:
	ldi transmitChar, 22       ;La posición del 0 en ASCII (48) menos las 26 posiciones del contador que no son números
	add transmitChar, counter  ;Dado a que ya resté 26, al sumar el contador sé qué número es
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