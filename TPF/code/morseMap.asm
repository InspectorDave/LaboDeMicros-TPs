/*
 * morseMap.asm
 *
 *  Created: 6/12/2022 05:08:33
 *   Author: ezequ
 */ 

morseAttention: .db "-.-.-", 0
morseOut: .db ".-.-.", 0

morseChars: .db ".-", 0, "-...", 0, "-.-.", 0, "-..", 0, ".", 0, "..-.", 0, "--.", 0, "....", 0, "..", 0,\
	".---", 0, "-.-", 0, ".-..", 0, "--", 0, "-.", 0, "---", 0, ".--.", 0 , "--.-", 0, ".-.", 0, "...", 0,\
	"-", 0, "..-", 0, "...-", 0, ".--", 0, "-..-", 0, "-.--", 0, "--..", 0, "-----", 0, ".----", 0,\
	"..---", 0, "...--", 0, "....-", 0, ".....", 0, "-....", 0, "--...", 0, "---..", 0, "----.", 0,\
	".-.-.-", 0, "--..--", 0, "..--..", 0, ".-..-.", 0, "-..-.", 0
	; A B C D E F G H I
	; J K L M N O P Q R S
	; T U V W X Y Z 0 1
	; 2 3 4 5 6 7 8 9 
	; . , ? " \