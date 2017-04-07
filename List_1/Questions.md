# Questions

## Exercise 1

Um sistema utiliza um microcontrolador 8051 para realizar a leitura de três grandezas (resolução de 8 bits cada) pelas portas P0, P1 e P2, e as salva em três posições na área de RAM interna (endereços 02h, 22h e 42h). 
Utilize a diretiva EQU para definição das posições na área da RAM interna com os nomes (GRAN1, GRAN2 e GRAN3) e realize a soma destas grandezas, considerando o overflow (estouro) de 8 bits. 
Salve o resultado na posição 20h.

## Exercise 2

Repita o programa anterior alterando a forma de armazenamento dos valores das grandezas para que seu próprio programa coloque os dados por endereçamento imediato para as posições e não mais pelas portas.
Conteúdo das posições de memória:
* (02h) = 4Fh
* (22h) = D1h
* (42h) = 11111010b

Analise brevemente o que ocorre quando a soma ultrapassa o valor máximo que 1 byte comporta (1111 1111b = FFh) para as duas somas.

## Exercise 3

Um sistema com o 8051 faz a leitura de três correntes, com dados de 16 bits cada, e os armazena nos endereços: COR1: (02h e 03h), COR2: (10h e 11h) e COR3: (80h e 81h).
Utilizando o modo de endereçamento indireto para acesso aos dados, realize a soma desses valores e armazene o resultado de 16 bits no endereço RES: (20h e 21h), e o estouro no endereço 22h .
Conteúdo das posições de memória:
* (02h) = 23H 
* (03h) = F5H
* (20h) = 01101110b 
* (21h) = 10101010b
* (80h) = C7H
* (81h) = 59

## Exercise 4

Um equipamento utiliza um microcontrolador 8051 para realizar a leitura de valores de resistores para facilitar a organização destes.
Para testar o equipamento, três valores padrão de resistores (1 byte cada) são alocados na memória de programa do microcontrolador (colocar estes dados após a última instrução do programa, no endereço relocável DADOS). 
Crie um programa que salve o menor valor de resistor na posição 20h e o maior na posição 30h da RAM externa. 
Execute o programa para os dois exemplos a seguir.

* Exemplo1

> + org 0
> + ini:
> + ;aqui o seu programa
> + ;aqui o seu programa
> + ;aqui o seu programa
> + aqui: sjmp aqui
> + DADOS: DB 220, 47, 180
> + End

* Exemplo2

> + org 0
> + ini:
> + ;aqui o seu programa
> + ;aqui o seu programa
> + ;aqui o seu programa
> + aqui: sjmp aqui
> + DADOS: DB 150, 220, 33
> + End

Para os exemplos:
1. Identificar a posição de endereços na memória de Programa onde os valores dos resistores estão armazenados.
2. O conteúdo da RAM Externa de Dados nas posições envolvidas, antes e depois da execução do programa.
