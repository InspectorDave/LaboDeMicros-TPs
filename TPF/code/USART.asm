configureUSART:
	;Baude rate
	ldi aux, 103
	sts UBRR0L, aux
	ldi aux, 0
	sts UBRR0H, aux

	;Status register A de la USART
	clr aux
	ldi aux, ((0<<MPCM0 | 0<<U2X0) | (0<<UPE0 | 0<<DOR0)) | ((0<<FE0 | 0<<UDRE0) | (0<<TXC0 | 0<<RXC0))
	sts UCSR0A, aux

	;Status register B de la USART
	clr aux
	ldi aux, ((0<<TXB80 | 0<<RXB80) | (0<<UCSZ02 | 1<<TXEN0)) | ((1<<RXEN0 | 0<<UDRIE0) | (0<<TXCIE0 | 0<<RXCIE0))
	sts UCSR0B, aux

	;Status register C de la USART
	clr aux
	ldi aux, ((0<<UCPOL0 | 1<<UCSZ00) | (1<<UCSZ01 | 0<<USBS0)) | ((0<<UPM00 | 0<<UPM01) | (0<<UMSEL00 | 0<<UMSEL01))
	sts UCSR0C, aux

	ret

transmitUSART:
	;Compruebo que pueda enviar un nuevo byte
	lds aux, UCSR0A
	sbrs aux, UDRE0
	rjmp transmitUSART

	sts UDR0, transmitChar
	ret

receiveUSART:
	;Cpmpruebo que pueda recibir un nuevo byte
	lds aux, UCSR0A	andi aux, 1<<RXC0
	sbrs aux, RXC0
	rjmp receiveUSART

	lds transmitChar, UDR0
	ret