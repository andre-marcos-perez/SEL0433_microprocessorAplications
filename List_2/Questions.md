# Questions

## Exercise 1

Construa um programa que escreva os valores pares de 20h a 40H na memória interna de dados a partir do endereço 30H e na memória externa de dados a partir do endereço 1000H. Utilize modo de endereçamento indireto para escrita nas duas regiões de memória.

## Exercise 2

Faça um programa que copie valores de tensão (em 16 bits – no formato little-endian (LSB MSB)) da região de memória externa de dados 60H a 7FH para a região de memória externa de dados que se inicia em 60H.

## Exercise 3

Fazer um programa que copie os caracteres de duas mensagens alocadas na área de memória de programa a partir do endereço relocável "MSG1 e MSG2" e coloque-os na memória interna de dados a partir do endereço 30H. A seqüência de dados na área de programa é finalizada com o código ASCII do caractere ‘$’ (código ASCII=24H) (usar apóstrofo, não o acento grave, nem aspas duplas). Determine o número de dados da seqüência e coloque-o no endereço 60h e 61h da RAM interna.

* Exemplo 1

> + ORG 0
> + MAIN:
> + ;aqui o seu programa
> + ;aqui o seu programa
> + ;aqui o seu programa
> + HERE: SJMP HERE
> + MSG1: DB 'MCU8051','$'
> + MSG2: DB 'SEL0433-2017',24h
> + END

## Exercise 4

Complemente o programa anterior para conferir se a mensagem 1 corresponde a palavra ‘MCU8051’. Se for verdadeiro, colocar P1.0 em nível lógico 1. Caso contrário, coloque em nível lógico 0. Da mesma
maneira, confira se a mensagem 2 corresponde à sequência 'SEL0433-2017', e caso verdadeiro coloque P1.7 em nível lógico 1, caso contrário em nível lógico 0. Dica: Utilize outra área da memória de programa para guardar a palavra esperada (‘MCU8051’). Deste modo você pode alterar os campos MSG1 ou MSG2 para algo diferente do esperado e notar que P1.0 e P1.7 não serão colocados em nível lógico 1.

## Exercise 5

Elabore uma rotina que faça a soma de dois valores de corrente com 24 bits (3 bytes) cada um. O primeiro valor de corrente está contido nas posições 1000h, 1001h e 1002h da RAM externa. O segundo valor de corrente está nas posições (R5), (R5+1), (R5+2), na RAM interna. O resultado deve ser colocado nas posições 20h, 21h e 22h da RAM interna. Para os três valores, o primeiro byte é o menos significativo (little-endian (LSB MSB)).

## Exercise 6

Considere a existência de uma tabela que contenha números aleatórios entre 0 e 255 (um número por byte), que começa na posição 5000H da RAM externa e tenha seu final delimitado pelo valor 0 (zero).
 * a) Faça uma rotina que conte o número de ocorrências na tabela igual ao valor contido no registrador R0 e retorne o resultado no registrador R1.
 * b) Utilize a rotina feita em a) para gerar uma tabela de ocorrências para todos os valores possíveis. Esta tabela deverá possuir 256 elementos, sendo o primeiro elemento o número de ocorrências do valor 0 na tabela original. O segundo elemento será o número de ocorrências do valor 1 na tabela original, e assim por diante. Analise se esta tabela deve ser salva na memória RAM interna, RAM externa, memória de programa interna ou memória de programa externa e explique o motivo.
 
 ## Exercise 7
 
Construa uma rotina que ordene por ordem crescente os elementos de uma tabela de valores de temperatura terminada com o byte 0 (zero). Coloque esta tabela na memória interna de dados iniciando no endereço 20h e que não exceda o enderço 7Fh. Esta tabela pode ter qualquer número de elementos desde que o último seja o byte 0 (zero). Após a execução da rotina, a tabela ordenada deve ser colocada a opartir do endereço 80h da RAM interna e conter o mesmo número de elementos e os mesmos elementos da original.
