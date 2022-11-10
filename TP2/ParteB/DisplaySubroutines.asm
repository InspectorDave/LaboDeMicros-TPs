;DisplaySubroutines.asm
;
;Created: 6/11/2022 01:59:48
;Author: Ezequiel Mundani Vegega 

cicleSegments: ;prendo cada led de a uno por 1 segundo
	ldi aux, segA
	out PORTC, aux
	call delay8Mcicles

	ldi aux, segB
	out PORTC, aux
	call delay8Mcicles

	ldi aux, segC
	out PORTC, aux
	call delay8Mcicles

	ldi aux, segD
	out PORTC, aux
	call delay8Mcicles

	ldi aux, segE
	out PORTC, aux
	call delay8Mcicles

	ldi aux, segF
	out PORTC, aux
	call delay8Mcicles

	clr aux
	out PORTC, aux ;limpio el puerto 
	ldi aux, segG  ;como esto sale por el puerto B, lo corro al pin correspondiente
	out PORTB, aux
	call delay8Mcicles

	clr aux        
	out PORTC, aux ;limpio el puerto C
	ldi aux, segO 
	out PORTB, aux 
	call delay8Mcicles

	clr aux
	out PORTB, aux ;apago todos los LEDs
	out PORTC, aux ;apago todos los LEDs
	ret

displayValue: 
;Establece el PORTC y PORTB con los bits correspondientes
;al número que se quiere mostrar
	display0:
		cpi dispValue, 0x0
		brne display1
		ldi aux, disp0C
		out PORTC, aux
		ldi aux, disp0B
		out PORTB, aux
		rjmp ret0
	display1:
		cpi dispValue, 0x1
		brne display2
		ldi aux, disp1C
		out PORTC, aux
		ldi aux, disp1B
		out PORTB, aux
		rjmp ret0
	display2:
		cpi dispValue, 0x2
		brne display3
		ldi aux, disp2C
		out PORTC, aux
		ldi aux, disp2B
		out PORTB, aux
		rjmp ret0
	display3:
		cpi dispValue, 0x3
		brne display4
		ldi aux, disp3C
		out PORTC, aux
		ldi aux, disp3B
		out PORTB, aux
		rjmp ret0
	display4:
		cpi dispValue, 0x4
		brne display5
		ldi aux, disp4C
		out PORTC, aux
		ldi aux, disp4B
		out PORTB, aux
		rjmp ret0
	display5:
		cpi dispValue, 0x5
		brne display6
		ldi aux, disp5C
		out PORTC, aux
		ldi aux, disp5B
		out PORTB, aux
		rjmp ret0
	display6:
		cpi dispValue, 0x6
		brne display7
		ldi aux, disp6C
		out PORTC, aux
		ldi aux, disp6B
		out PORTB, aux
		rjmp ret0
	display7:
		cpi dispValue, 0x7
		brne display8
		ldi aux, disp7C
		out PORTC, aux
		ldi aux, disp7B
		out PORTB, aux
		rjmp ret0
	display8:
		cpi dispValue, 0x8
		brne display9
		ldi aux, disp8C
		out PORTC, aux
		ldi aux, disp8B
		out PORTB, aux
		rjmp ret0
	display9:
		cpi dispValue, 0x9
		brne displayA
		ldi aux, disp9C
		out PORTC, aux
		ldi aux, disp9B
		out PORTB, aux
		rjmp ret0
	displayA:
		cpi dispValue, 0xA
		brne displayB
		ldi eepromAddress,0x0
		call eepromRead 
		out PORTC, aux
		call eepromRead 
		out PORTB, aux
		rjmp ret0
	displayB:
		cpi dispValue, 0xB
		brne displayC
		ldi eepromAddress,0x2
		call eepromRead 
		out PORTC, aux
		call eepromRead 
		out PORTB, aux
		rjmp ret0
	displayC:
		cpi dispValue, 0xC
		brne displayD
		ldi eepromAddress,0x4
		call eepromRead 
		out PORTC, aux
		call eepromRead 
		out PORTB, aux
		rjmp ret0
	displayD:
		cpi dispValue, 0xD
		brne displayE
		ldi eepromAddress,0x6
		call eepromRead 
		out PORTC, aux
		call eepromRead 
		out PORTB, aux
		rjmp ret0
	displayE:
		cpi dispValue, 0xE
		brne displayF
		ldi eepromAddress,0x8
		call eepromRead 
		out PORTC, aux
		call eepromRead 
		out PORTB, aux
		rjmp ret0
	displayF:
		cpi dispValue, 0xF
		brne displayError
		ldi eepromAddress,0xA
		call eepromRead 
		out PORTC, aux
		call eepromRead 
		out PORTB, aux
		rjmp ret0
	displayError:
		ldi dispValue, 0
		rjmp display0
	ret0:
		ldi eepromAddress,lastValueAddress
		call eepromWrite
		ret

writeLettersInEEprom:
	ldi eepromAddress,0x0
	ldi aux, dispAC
	call eepromWrite
	ldi aux, dispAB
	call eepromWrite

	ldi aux, dispBC
	call eepromWrite
	ldi aux, dispBB
	call eepromWrite

	ldi aux, dispCC
	call eepromWrite
	ldi aux, dispCB
	call eepromWrite

	ldi aux, dispDC
	call eepromWrite
	ldi aux, dispDB
	call eepromWrite

	ldi aux, dispEC
	call eepromWrite
	ldi aux, dispEB
	call eepromWrite

	ldi aux, dispFC
	call eepromWrite
	ldi aux, dispFB
	call eepromWrite
	ret
