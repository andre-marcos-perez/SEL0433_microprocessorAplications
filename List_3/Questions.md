# Questions

## Exercise 1

Escolha um timer interno do 8051 e crie uma rotina de delay de 0.05 segundos. Utilizando este programa como sub-rotina, escrever um programa que gere uma rotina de delay de 1 segundo.

## Exercise 2

Fazer um programa em Assembly que gere uma onda quadrada na porta P1.0 com período de 1.0ms e duty clycle de 25%. Utilize Timer 0 no Modo 0 e considere um cristal oscilador de 12MHz. Repita a resolução considerando um cristal oscilador de 11,0592MHz. Forneça os parâmetros de tempo envolvidos para ambos os casos.

## Exercise 3

Fazer um contador hexadecimal crescente que coloque o valor de contagem na porta P2 em intervalos de 250 ciclos de máquina. Utilize o Timer 1 no modo 2 para a contagem de tempo.

## Exercise 4

Um microcontrolador 8051 controla um sistema de iluminação eletrônica, amplamente utilizado em casas noturnas e shows, que opera em 4 modos distintos. O hardware do sistema é composto por 8 lâmpadas de LED conectadas na porta 0 e por duas chaves seletoras de modo de operação conectadas tanto em P1.0 e P1.1 quanto aos pinos Int0 e Int1, respectivamente. Toda vez que uma chave seletora muda de estado, é enviado uma descida de borda ao seu pino de interrupção equivalente. Por fim, o botão conectado na porta P1.2 complementa o estado das lâmpadas de LED. Fazer um programa em Assembly que fique em loop infinito e, através de interrupções, opere o sistema de iluminação eletrônica, piscando as lâmpadas de LED a uma frequência específica, de acordo com a tabela abaixo.

<table>
    <tr>
        <td>Modo de Operação</td>
        <td>P1.0</td>
        <td>P1.1</td>
        <td>P1.2</td>
        <td>P0.7</td>
        <td>P0.6</td>
        <td>P0.5</td>
        <td>P0.4</td>
        <td>P0.3</td>
        <td>P0.2</td>
        <td>P0.1</td>
        <td>P0.0</td>
        <td>Frequência (Hz)</td>
    </tr>
    <tr>
        <td>Modo 1</td>
        <td>L</td>
        <td>L</td>
        <td>L</td>
        <td>H</td>
        <td>L</td>
        <td>H</td>
        <td>L</td>
        <td>H</td>
        <td>L</td>
        <td>H</td>
        <td>L</td>
        <td>10</td>
    </tr>
    <tr>
        <td></td>
        <td></td>
        <td></td>
        <td>H</td>
        <td>L</td>
        <td>H</td>
        <td>L</td>
        <td>H</td>
        <td>L</td>
        <td>H</td>
        <td>L</td>
        <td>H</td>
        <td></td>
    </tr>
        <tr>
        <td>Modo 2</td>
        <td>L</td>
        <td>H</td>
        <td>L</td>
        <td>L</td>
        <td>L</td>
        <td>L</td>
        <td>L</td>
        <td>H</td>
        <td>H</td>
        <td>H</td>
        <td>H</td>
        <td>5</td>
    </tr>
    <tr>
        <td></td>
        <td></td>
        <td></td>
        <td>H</td>
        <td>H</td>
        <td>H</td>
        <td>H</td>
        <td>H</td>
        <td>L</td>
        <td>L</td>
        <td>L</td>
        <td>L</td>
        <td></td>
    </tr>
        <tr>
        <td>Modo 3</td>
        <td>H</td>
        <td>L</td>
        <td>L</td>
        <td>H</td>
        <td>H</td>
        <td>L</td>
        <td>L</td>
        <td>H</td>
        <td>H</td>
        <td>L</td>
        <td>L</td>
        <td>10</td>
    </tr>
    <tr>
        <td></td>
        <td></td>
        <td></td>
        <td>H</td>
        <td>L</td>
        <td>L</td>
        <td>H</td>
        <td>H</td>
        <td>L</td>
        <td>L</td>
        <td>H</td>
        <td>H</td>
        <td></td>
    </tr>
        <tr>
        <td>Modo 4</td>
        <td>H</td>
        <td>H</td>
        <td>L</td>
        <td>H</td>
        <td>H</td>
        <td>L</td>
        <td>L</td>
        <td>L</td>
        <td>L</td>
        <td>H</td>
        <td>H</td>
        <td>10</td>
    </tr>
    <tr>
        <td></td>
        <td></td>
        <td></td>
        <td>H</td>
        <td>L</td>
        <td>L</td>
        <td>H</td>
        <td>H</td>
        <td>H</td>
        <td>H</td>
        <td>L</td>
        <td>L</td>
        <td></td>
    </tr>
</table>

## Exercise 5

Desenvolver um programa em Assembly do 8051 que ordene de maneira crescente uma sequência de números inteiros de 1 byte armazenada na memória de programa e envie alternadamente seus valores para as portas P0 e P1 a uma frequência de 30Hz. A sequência na memória de programa é a seguinte: 58, ED, 90, 6E, 2C, 2F, 5E, A2, A8 e E0.

## Exercise 6

Uma rotina recursiva é uma rotina que resolve um problema chamando a si mesma até que a solução seja encontrada. Para que esta rotina não chame a si mesma infinitamente, define-se uma condição de parada ou condição básica. Portanto, uma rotina recursiva é composta por dois casos distintos: um de parada e um caso recursivo. Funções recursivas utilizam intensamente a pilha e consequentemente seu ponteiro, o stack pointer (SP). Observe o código abaixo.

```assembly
    org 0
    mov r7, #05h
    lcall recursion
    sjmp $
recursion:
    cjne r7, #00h, continue
    ret
continue:
    dec r7
    lcall recursion
    ret
    end
```

a. Compile o código acima e simule-o acompanhando o comportamento da pilha na memória de dados interna e do registrador SP. Descreva o comportamento de ambos.
b. Qual é o caso de parada e o caso recursivo do código?
c. Qual o valor que R7 deve assumir para que ocorra um <i>stack overflow</i>?
d. Modifique o código para que este seja capaz de calcular a potência de um número de 1 byte. Envie o resultado para a porta P1 e salve um eventual carry no bit P2.0.

## Exercise 7

Escrever um programa em Assembly para o controle do dispositivo de teste térmico de materiais presente na abaixo. Um recipiente com uma determinada substância sob teste deve ser abaixado para dentro de um forno por um motor. O sensor 1 detecta a presença do recipiente dentro do forno e envia uma descida de borda ao pino Int0 do microprocessador. Este então desliga o motor e aciona o aquecimento do forno por 500ms, aproximadamente. Em seguida, o microprocessador desliga o aquecimento e inverte o sentido do motor, erguendo o recipiente. Quando este atinge a posição do sensor 2, é enviada uma descida de borda ao pino Int1. Quando Int1 receber esta descida de borda, o microprocessador deve parar o motor e acionar o resfriamento durante aproximadamente 250 ms. O ciclo deve ser repetido 3 vezes e, ao final do processo, o microprocessador deve acender um LED de sinalização e parar. Antes do começo da operação, inicie todos os componentes desligados, seu funcionamento está presente na tabela 2, e considere que a posição inicial do recipiente está acima do sensor 2. Por fim, considere o cristal da CPU de 12 MHz.

<table>
    <tr>
        <td>Componente</td>
        <td>Microprocessador</td>
        <td>Nível lógico alto</td>
        <td>Nível lógico baixo</td>
    </tr>
    <tr>
        <td>Motor</td>
        <td>P2.6</td>
        <td>Desliga</td>
        <td>Liga</td>
    </tr>
        <tr>
        <td>Direção do Motor</td>
        <td>P2.7</td>
        <td>Horário</td>
        <td>Anti-Horário</td>
    </tr>
        <tr>
        <td>Resfriamento</td>
        <td>P1.0</td>
        <td>Liga</td>
        <td>Desliga</td>
    </tr>
        <tr>
        <td>Aquecimento</td>
        <td>P1.2</td>
        <td>Liga</td>
        <td>Desliga</td>
    </tr>
        <tr>
        <td>LED</td>
        <td>P0.5</td>
        <td>Liga</td>
        <td>Desliga</td>
    </tr>
    <tr>
        <td>Sensor 1</td>
        <td>Int0</td>
        <td>----</td>
        <td>----</td>
    </tr>
    <tr>
        <td>Sensor 2</td>
        <td>Int1</td>
        <td>----</td>
        <td>----</td>
    </tr>
</table>

## Hardware - Exercise 7

![hardware](./hardware.png "Hardware")
