;DisplaySubroutines.asm
;
;Created: 6/11/2022 01:59:48
;Author: Ezequiel Mundani Vegega 

cicleLetters: ;muestro las letras de la A a la F
	ldi dispValue, 0xA
	call displayValue
	call delay8Mcicles
	ldi dispValue, 0xB
	call displayValue
	call delay8Mcicles
	ldi dispValue, 0xC
	call displayValue
	call delay8Mcicles
	ldi dispValue, 0xD
	call displayValue
	call delay8Mcicles
	ldi dispValue, 0xE
	call displayValue
	call delay8Mcicles
	ldi dispValue, 0xF
	call displayValue
	call delay8Mcicles
	ret

displayValue: 
;Establece el PORTC y PORTD con los bits correspondientes
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
	ldi zl, low((displayTable*2))
	ldi zh, high((displayTable*2))
	rjmp writePorts1

display1:
	ldi zl, low((displayTable*2)+1)
	ldi zh, high((displayTable*2)+1)
	rjmp writePorts1
	
display2:
	ldi zl, low((displayTable*2)+2)
	ldi zh, high((displayTable*2)+2)
	rjmp writePorts1

display3:
	ldi zl, low((displayTable*2)+3)
	ldi zh, high((displayTable*2)+3)
	rjmp writePorts1

display4:
	ldi zl, low((displayTable*2)+4)
	ldi zh, high((displayTable*2)+4)
	rjmp writePorts1

display5:
	ldi zl, low((displayTable*2)+5)
	ldi zh, high((displayTable*2)+5)
	rjmp writePorts1

display6:
	ldi zl, low((displayTable*2)+6)
	ldi zh, high((displayTable*2)+6)
	rjmp writePorts1

display7:
	ldi zl, low((displayTable*2)+7)
	ldi zh, high((displayTable*2)+7)
	rjmp writePorts1	

display8:
	ldi zl, low((displayTable*2)+8)
	ldi zh, high((displayTable*2)+8)
	rjmp writePorts1

display9:
	ldi zl, low((displayTable*2)+9)
	ldi zh, high((displayTable*2)+9)
	rjmp writePorts1

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

writePorts1:
	lpm aux, z
	andi aux, 0x0F
	in aux2, PORTC
	andi aux2, 0xF0
	or aux, aux2
	out PORTC, aux

	lpm aux, z
	andi aux, 0xF0
	in aux2, PORTD
	andi aux2, 0x0F
	or aux, aux2
	out PORTD, aux
	ret

displayA:
	ldi eepromAddress,0x0
	rjmp writePorts2

displayB:
	ldi eepromAddress,0x2
	rjmp writePorts2

displayC:
	ldi eepromAddress,0x4
	rjmp writePorts2

displayD:
	ldi eepromAddress,0x6
	rjmp writePorts2

displayE:
	ldi eepromAddress,0x8
	rjmp writePorts2

displayF:
	ldi eepromAddress,0xA
	rjmp writePorts2

writePorts2:
	call eepromRead 
	andi aux, 0x0F
	in aux2, PORTC
	andi aux2, 0xF0
	or aux, aux2
	out PORTC, aux

	call eepromRead 
	andi aux, 0xF0
	in aux2, PORTD
	andi aux2, 0x0F
	or aux, aux2
	out PORTD, aux
	ret