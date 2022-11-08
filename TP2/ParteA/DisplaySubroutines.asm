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
	ldi aux, segO  ;como esto sale por el puerto B, lo corro al pin correspondiente
	out PORTB, aux 
	call delay8Mcicles

	clr aux
	out PORTB, aux ;apago todos los LEDs
	out PORTC, aux ;apago todos los LEDs

	ret

displayValue: 
;Establece el PORTC y PORTB con los bits correspondientes
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
	breq displayA_
	cpi dispValue, 0xB
	breq displayB_
	cpi dispValue, 0xC
	breq displayC_
	cpi dispValue, 0xD
	breq displayD_
	cpi dispValue, 0xE
	breq displayE_
	cpi dispValue, 0xF
	breq displayF_

display0:
	ldi aux, disp0C
	out PORTC, aux
	ldi aux, disp0B
	out PORTB, aux
	ret

display1:
	ldi aux, disp1C
	out PORTC, aux
	ldi aux, disp1B
	out PORTB, aux
	ret

display2:
	ldi aux, disp2C
	out PORTC, aux
	ldi aux, disp2B
	out PORTB, aux
	ret

display3:
	ldi aux, disp3C
	out PORTC, aux
	ldi aux, disp3B
	out PORTB, aux
	ret

display4:
	ldi aux, disp4C
	out PORTC, aux
	ldi aux, disp4B
	out PORTB, aux
	ret

display5:
	ldi aux, disp5C
	out PORTC, aux
	ldi aux, disp5B
	out PORTB, aux
	ret

display6:
	ldi aux, disp6C
	out PORTC, aux
	ldi aux, disp6B
	out PORTB, aux
	ret

display7:
	ldi aux, disp7C
	out PORTC, aux
	ldi aux, disp7B
	out PORTB, aux
	ret

display8:
	ldi aux, disp8C
	out PORTC, aux
	ldi aux, disp8B
	out PORTB, aux
	ret

display9:
	ldi aux, disp9C
	out PORTC, aux
	ldi aux, disp9B
	out PORTB, aux
	ret

;Los saltos eran demasiado largos así que agrego estos saltos
;en el medio
displayA_:
	rjmp displayA
displayB_:
	rjmp displayB
displayC_:
	rjmp displayC
displayD_:
	rjmp displayD
displayE_:
	rjmp displayE
displayF_:
	rjmp displayF

displayA:
	ldi eepromAddress,0x0
	call eepromRead 
	out PORTC, aux
	call eepromRead 
	out PORTB, aux
	ret

displayB:
	ldi eepromAddress,0x2
	call eepromRead 
	out PORTC, aux
	call eepromRead 
	out PORTB, aux
	ret

displayC:
	ldi eepromAddress,0x4
	call eepromRead 
	out PORTC, aux
	call eepromRead 
	out PORTB, aux
	ret

displayD:
	ldi eepromAddress,0x6
	call eepromRead 
	out PORTC, aux
	call eepromRead 
	out PORTB, aux
	ret

displayE:
	ldi eepromAddress,0x8
	call eepromRead 
	out PORTC, aux
	call eepromRead 
	out PORTB, aux
	ret

displayF:
	ldi eepromAddress,0xA
	call eepromRead 
	out PORTC, aux
	call eepromRead 
	out PORTB, aux
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
