#ifndef _display7segments_
#define _display7segments_

;Los segmentos desde A hasta F se muestran por el puerto C
;Los segmentos G y O por le puerto B.
;Por eso hay máscaras repetidas
.equ segA = 0b00000001
.equ segB = 0b00000010
.equ segC = 0b00000100
.equ segD = 0b00001000
.equ segE = 0b00010000
.equ segF = 0b00100000
.equ segG = 0b00000001
.equ segO = 0b00000010

.equ disp0C = 0b00111111
.equ disp1C = 0b00000110
.equ disp2C = 0b01011011
.equ disp3C = 0b01001111
.equ disp4C = 0b01100110
.equ disp5C = 0b01101101
.equ disp6C = 0b00111101
.equ disp7C = 0b00000111
.equ disp8C = 0b01111111
.equ disp9C = 0b01100111
.equ dispAC = 0b01110111
.equ dispBC = 0b01111100
.equ dispCC = 0b00111001
.equ dispDC = 0b01011110
.equ dispEC = 0b01111001
.equ dispFC = 0b01110001

.equ disp0B = 0b00000000
.equ disp1B = 0b00000000
.equ disp2B = 0b00000001
.equ disp3B = 0b00000001
.equ disp4B = 0b00000001
.equ disp5B = 0b00000001
.equ disp6B = 0b00000001
.equ disp7B = 0b00000000
.equ disp8B = 0b00000001
.equ disp9B = 0b00000001
.equ dispAB = 0b00000001
.equ dispBB = 0b00000001
.equ dispCB = 0b00000000
.equ dispDB = 0b00000001
.equ dispEB = 0b00000001
.equ dispFB = 0b00000001

#endif
