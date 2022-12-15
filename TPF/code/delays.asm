; delays.asm

; Created: 6/12/2022 05:35:45
; Author: Ezequiel Mundani

delay16kcicles: ;1ms a 16MHz
	ldi aux, 1
	ldi aux2, 30
	ldi aux3, 226
	L2:
		dec aux3
		brne L2
		dec aux2
		brne L2
		dec aux
		brne L2
	nop
	nop
	ret
