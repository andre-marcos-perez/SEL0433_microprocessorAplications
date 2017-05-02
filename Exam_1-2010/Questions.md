
## Questions

# Exercise 1

Um sistema baseado no Microcontrolador 8051 utiliza as duas interrupções externas, a interrupção da comunicação serial e a interrupção gerada pela timer/contador 0. Escrever um programa em Assembly com as características abaixo.
1. A interrupção externa 0, de alta prioridade, deve trocar o que está na porta P1 com o que está contido na posição de ram externa 5000h.
2. A interrupção externa 1, com baixa prioridade, deve transferir o que está armazenado no endereço 5000h da ram externa para o endereço 7Fh da ram interna.
3. A interrupção do timer/contador 0 (a cada 50ms), de alta prioridade, deve executar uma rotina que copie o conteudo do endereço 7Fh da ram interna para o endereço 5200h da ram externa.
4. A interrupção serial, de baixa prioridade, deve enviar a cada 5 segundos aproximadamente o conteudo do endereço 5200h pela interface serial RS232 no formato 9600/8-N-1.

O programa deve ficar em loop infinito executando o algoritmo acima. Considerar um cristal de 11.0592 MHz.

# Exercise 2

Utilizando instruções que endereçam bits do Microcontrolador 8051, escrever um programa em assembly que mova os bits do endereço 20h da ram interna para o endereço 2Fh da ram interna na ordem inversa, ou seja, o LSB (bit menos significativo) do endereço 20h vai para o MSB (bit mais significativo) do endereço 2Fh. O programa deve para quando o MSB do endereço 20h estiver no LSB do endereço 2Fh.

# Exercise 3

Considere o programa abaixo escrito para o microcontrolador 8051 para responder cada um dos itens.

```assembly
	ORG 0
INIT:	MOV	DPTR,#100H
	MOV	R1,#10D
VOLTA:	MOV	A,R1
	MOV	R0,#10D
LOOP:	CPL	P2.1
	DJNZ	R0,LOOP
	MOVX	@DPTR,A
	INC	DPTR
	INC	R1
	CJNE	R1,#20D,VOLTA
	SJMP	$
	END
```
1. Quais são os endereços absolutos equivalentes aos <i>labels</i> INIT e VOLTA?
2. Qual será o conteúdo em hexadecimal do endereço 0108h da ram externa após a execução do programa?
3. Qual será o conteúdo em hexadecimal do registrador R1 após a execução do programa?
4. Se um led estiver ligado na porta P2.1, quantas vezes ele ascenderá durante a execução do programa?
