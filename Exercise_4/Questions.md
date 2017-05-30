# Questions

Considere o seguinte esquema de hardware:

 * O microcontrolador está conectado a um monitor de vídeo e a um teclado ASCII
 * Um motor de passo também é um periférico deste microcontrolador. Seu funcionamento pode ser conferido na tabela abaixo.
 
 <table>
    <tr>
        <td>P1.0</td>
        <td>P1.1</td>
    </tr>
    <tr>
        <td>Clock</td>
        <td>Direção</td>
    </tr>
 </table>

Fazer um programa em assembly que receba através do teclado um número decimal de passos (00 a 99) digitado pelo usuário seguido de uma letra (H para sentido horário e A para sentido anti-horário).
O programa aciona o motor de passo e executa o comando solicitado, atualizando no vídeo a cada passo dado seguido da direção (horário ou anti-horário).
Permitir que possam ser inseridos até 4 comandos diferentes.
