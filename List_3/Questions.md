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
        <td>10</td>
    </tr>
</table>
