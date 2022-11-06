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
	cpi dispValue, 0x0
	breq display0
	cpi dispValue, 0x1
	breq display1
	cpi dispValue, 0x2
	breq display2
	cpi dispValue, 0x3
	breq display3
	cpi dispValue, 0x4
	breq display4
	cpi dispValue, 0x5
	breq display5
	cpi dispValue, 0x6
	breq display6
	cpi dispValue, 0x7
	breq display7
	cpi dispValue, 0x8
	breq display8
	cpi dispValue, 0x9
	breq display9
	cpi dispValue, 0xA
	breq displayA
	cpi dispValue, 0xB
	breq displayB
	cpi dispValue, 0xC
	breq displayC
	cpi dispValue, 0xD
	breq displayD
	cpi dispValue, 0xE
	breq displayE
	cpi dispValue, 0xF
	breq displayF

display0:
	ldi aux, disp0
	out PORTB, aux
	ret

display1:
	ldi aux, disp1
	out PORTB, aux
	ret

display2:
	ldi aux, disp2
	out PORTB, aux
	ret

display3:
	ldi aux, disp3
	out PORTB, aux
	ret

display4:
	ldi aux, disp4
	out PORTB, aux
	ret

display5:
	ldi aux, disp5
	out PORTB, aux
	ret

display6:
	ldi aux, disp6
	out PORTB, aux
	ret

display7:
	ldi aux, disp7
	out PORTB, aux
	ret

display8:
	ldi aux, disp8
	out PORTB, aux
	ret

display9:
	ldi aux, disp9
	out PORTB, aux
	ret

displayA:
	ldi eepromAddress,0x0
	call eepromRead 
	out PORTB, aux
	ret

displayB:
	ldi eepromAddress,0x1
	call eepromRead 
	out PORTB, aux
	ret

displayC:
	ldi eepromAddress,0x2
	call eepromRead 
	out PORTB, aux
	ret

displayD:
	ldi eepromAddress,0x3
	call eepromRead 
	out PORTB, aux
	ret

displayE:
	ldi eepromAddress,0x4
	call eepromRead 
	out PORTB, aux
	ret

displayF:
	ldi eepromAddress,0x5
	call eepromRead 
	out PORTB, aux
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
