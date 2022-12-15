; timersConfiguration.asm
;
; Created: 9/12/2022 08:31:32
; Author: Ezequiel Mundani

configureTimer1ICU1:
	; Hago que la interrupción de input capture unit sea por flanco ascendente y el timer esté frenado
	ldi aux, (1<<ICES1 | 0<<WGM13 | 0<<WGM12 | 0<<CS12 | 0<<CS11 | 0<<CS10)
	sts TCCR1B, aux

	ldi aux, (0<<OCIE1A | 1<<ICIE1) ;Habilito la interrupción de input capture unit
	sts TIMSK1, aux

	ret

configureTimer1ICU2:
	; Hago que la interrupción de input capture unit sea por flanco descendente y el timer comience
	ldi aux, (0<<ICES1 | 0<<WGM13 | 0<<WGM12 | 1<<CS12 | 0<<CS11 | 1<<CS10)
	sts TCCR1B, aux

	ret

configureTimer1CTC:
	; Hago que el timer al llegar a TOP genere una interrupción y que TOP sea ICR1, es decir la duración capturada.
	ldi aux, (0<<ICES1 | 1<<WGM13 | 1<<WGM12 | 1<<CS12 | 0<<CS11 | 1<<CS10)
	sts TCCR1B, aux

	ldi aux, (1<<OCIE1A | 0<<ICIE1) ; Habilito la interrupción al llegar a TOP y deshabilito la del ICU
	sts TIMSK1, aux

	cli               ; Pongo al timer en la mitad de TOP, de esta manera
	lds aux, ICR1L    ; se activará la interrupción a la mitad del bit.
	lds aux2, ICR1H   ;
	lsr aux2          ; Para ponerlo a la mitad, divido por dos, que es lo mismo
	ror aux           ; que hacer un shift right
	sts TCNT1H, aux2  ;
	sts TCNT1L, aux   ;
	sei               ;

	ret
 
