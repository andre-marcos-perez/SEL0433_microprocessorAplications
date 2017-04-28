# Estudo de Caso: Spotting Endianness

André, em sua busca por estágio, conseguiu uma entrevista em uma empresa de software. Durante a entrevista técnica, o engenheiro de software responsável por conduzi-la propôs o problema abaixo.

> “Create a function to verify if a 32-bit processor uses little or big endian without knowing its designer. You can use the programming language of your choice. ”

André sabia o que era endianness, o que ele não sabia é que um processador que utiliza little endian “corrige” o dado em toda a instrução de movimento, tornando o seu endianness transparente ao programador.

## Part A

Em Assembly, crie a função proposta para o processador utilizado na disciplina. 

## Part B

Em C, crie a função proposta para a arquitetura especificada utilizando o padrão C90 e assuma que todas a IDE utilizadas para programar os diferentes processadores compilem a linguagem neste padrão, permitindo assim que a mesma função possa ser compilada para qualquer processador.
