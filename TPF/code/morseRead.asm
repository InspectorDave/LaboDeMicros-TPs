 ; morseRead.asm
 ;
 ; Created: 7/12/2022 20:00:46
 ; Author: Ezequiel Mundani

 .equ inputPin = 0b00000001
 .equ inputPinHigh = 0b00000001
 .equ inputPinLow = 0b00000000

readValue: ;Lee el valor de la señal de entrada
	keepWaiting:
		cpi topReached, 1
		brne keepWaiting

	ldi topReached, 0
	in aux, PINB
	andi aux, inputPin

	ret

noReadingLoop:
	call readValue
	cpi aux, inputPinHigh
	breq firstHighRead

	rjmp noReadingLoop

firstHighRead:
	call readValue
	cpi aux, inputPinHigh
	breq secondHighRead

	ldi aux, '.'
	st x+, aux
	rjmp firstLowRead
	
secondHighRead:
	call readValue
	cpi aux, inputPinLow
	breq morseError

	rjmp thirdHighRead

thirdHighRead:
	call readValue
	call ifHighError

	ldi aux, '-'
	st x+, aux
	rjmp firstLowRead

firstLowRead:
	call readValue
	cpi aux, inputPinHigh
	breq firstHighRead

	rjmp secondLowRead
	
secondLowRead:
	call readValue
	call ifHighError

	ldi aux, 0
	st x+, aux
	call identifyChar
	call transmitUsart
	
	ldi	xh, high(readSign)
	ldi	xl, low (readSign)

	rjmp thirdLowRead

thirdLowRead:
	call readValue
	cpi aux, inputPinHigh
	breq firstHighRead

	rjmp fourthLowRead

fourthLowRead:
	call readValue
	call ifHighError

	rjmp fifthLowRead
	
fifthLowRead:
	call readValue
	call ifHighError
	
	rjmp sixthLowRead

sixthLowRead:
	call readValue
	call ifHighError

	ldi transmitChar, ' '
	call transmitUsart
	rjmp seventhLowRead

seventhLowRead:
	call readValue
	cpi aux, inputPinHigh
	breq firstHighRead

	rjmp noReadingLoop

morseError:
	ldi aux, 0
	st x+, aux
		
	ldi	xh, high(readSign)
	ldi	xl, low (readSign)

	ret
	
ifHighError:
	cpi aux, inputPinHigh
	brne retIfHighError

	call morseError

	retIfHighError:
		ret