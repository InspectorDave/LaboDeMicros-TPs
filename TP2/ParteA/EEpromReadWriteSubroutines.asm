;EEpromReadWriteSubroutines.asm
;
;Created: 6/11/2022 01:51:59
;Author: Ezequiel Mundani

;Se escribe/lee en eepromAdress se 'escribe desde/lee a' aux

eepromWrite:
	sei                     ;disable interruptions
	sbic EECR,EEPE          ;check if EEprom busy
	rjmp eepromWrite        ;check until not busy

	out EEARL,eepromAddress ;set up the address
	out EEDR,aux            ;EEprom data to write

	sbi EECR,EEMPE          ;enable EEprom
	sbi EECR,EEPE           ;enable write, here the writing takes place

	inc eepromAddress       ;increment EEprom address
	cli                     ;enable interruptions
	ret

eepromRead:
	sei						;disable interruptions
	sbic EECR,EEPE          ;check if EEprom busy
	rjmp eepromRead         ;check until not busy

	out EEARL,eepromAddress ;set up the address

	sbi EECR,EERE           ;set up for reading
	in  aux,EEDR            ;read the data register

	inc eepromAddress       ;inc EEprom address
	cli                     ;enable interruptions
	ret