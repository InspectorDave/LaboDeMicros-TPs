;DisplaySubroutines.asm
;
;Created: 6/11/2022 01:59:48
;Author: Ezequiel Mundani Vegega 

cicleSegments: ;prendo cada led de a uno por 1 segundo
	ldi aux, segA
	out PORTB, aux
	call delay8Mcicles
	ldi aux, segB
	out PORTB, aux
	call delay8Mcicles
	ldi aux, segC
	out PORTB, aux
	call delay8Mcicles
	ldi aux, segD
	out PORTB, aux
	call delay8Mcicles
	ldi aux, segE
	out PORTB, aux
	call delay8Mcicles
	ldi aux, segF
	out PORTB, aux
	call delay8Mcicles
	ldi aux, segG
	out PORTB, aux
	call delay8Mcicles
	ldi aux, segO
	out PORTB, aux
	call delay8Mcicles
	ret

displayValue: 
;Establece el PORTB con los bits correspondientes
;al número que se quiere mostrar
	display0:
		cpi dispValue, 0x0
		brne display1
		ldi aux, disp0
		rjmp ret0
	display1:
		cpi dispValue, 0x1
		brne display2
		ldi aux, disp1
		rjmp ret0
	display2:
		cpi dispValue, 0x2
		brne display3
		ldi aux, disp2
		rjmp ret0
	display3:
		cpi dispValue, 0x3
		brne display4
		ldi aux, disp3
		rjmp ret0
	display4:
		cpi dispValue, 0x4
		brne display5
		ldi aux, disp4
		rjmp ret0
	display5:
		cpi dispValue, 0x5
		brne display6
		ldi aux, disp5
		rjmp ret0
	display6:
		cpi dispValue, 0x6
		brne display7
		ldi aux, disp6
		rjmp ret0
	display7:
		cpi dispValue, 0x7
		brne display8
		ldi aux, disp7
		rjmp ret0
	display8:
		cpi dispValue, 0x8
		brne display9
		ldi aux, disp8
		rjmp ret0
	display9:
		cpi dispValue, 0x9
		brne displayA
		ldi aux, disp9
		rjmp ret0
	displayA:
		cpi dispValue, 0xA
		brne displayB
		ldi eepromAddress, 0x00
		call eepromRead
		rjmp ret0
	displayB:
		cpi dispValue, 0xB
		brne displayC
		ldi eepromAddress, 0x01
		call eepromRead
		rjmp ret0
	displayC:
		cpi dispValue, 0xC
		brne displayD
		ldi eepromAddress, 0x02
		call eepromRead
		rjmp ret0
	displayD:
		cpi dispValue, 0xD
		brne displayE
		ldi eepromAddress, 0x03
		call eepromRead
		rjmp ret0
	displayE:
		cpi dispValue, 0xE
		brne displayF
		ldi eepromAddress, 0x04
		call eepromRead
		rjmp ret0
	displayF:
		cpi dispValue, 0xF
		brne displayError
		ldi eepromAddress, 0x05
		call eepromRead
		rjmp ret0
	displayError:
		ldi dispValue, 0
		ldi aux, disp0
	ret0:
		out PORTB, aux
		ldi eepromAddress,lastValueAddress
		call eepromWrite
		ret

writeLettersInEEprom:
	ldi aux, dispA
	call eepromWrite
	ldi aux, dispB
	call eepromWrite
	ldi aux, dispC
	call eepromWrite
	ldi aux, dispD
	call eepromWrite
	ldi aux, dispE
	call eepromWrite
	ldi aux, dispF
	call eepromWrite
	ret
