;
;EEpromReadWriteSubroutines.asm
;
;Created: 6/11/2022 01:51:59
;Author: Ezequiel Mundani

;Se escribe/lee en eepromAdress se 'escribe desde/lee a' aux

eepromWrite:
	sbic EECR,EEPE          ;CHECK IF EEPROM AVAILABLE
	rjmp eepromWrite        ;LOOP-BACK IF NOT AVAILABLE

	out EEARL,eepromAddress ;EPROM ADDRESS
	out EEDR,aux            ;EEPROM DATA TO WRITE

	sbi EECR,EEMPE          ;ENABLE EEPROM
	sbi EECR,EEPE           ;ENABLE WRITE, en este paso se escribe la EEPROM

	inc eepromAddress       ;INCREMENT EEPROM ADDRESS
	ret

eepromRead:
	sbic EECR,EEPE          ;CHECK IF EEPROM BUSY
	rjmp eepromRead         ;ITS BUSY SO WE WAIT

	out EEARL,eepromAddress ;SET-UP THE ADDRESS

	sbi EECR,EERE           ;SET-UP TO READ
	in  aux,EEDR              ;READ THE DATA REGISTER

	inc eepromAddress       ;INCREMENT EEPROM ADDRESS
	ret