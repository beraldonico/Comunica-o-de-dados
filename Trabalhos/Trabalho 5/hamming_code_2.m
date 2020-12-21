clear all

#Transmissor
#criacao de dados
dados = [0 1 1 1 1 1 0];
disp(["mensagem enviada:   " num2str(dados)])
#Verificar quantos BITs são necessarios
R = 0;
do
    R++;
until(2^R >= length(dados) + R + 1)
#soma do tamnnho de dados e da quantidade de BITs de paridade
tamanho_msg = length(dados) + R;

#Criar msg
#zerar msg inicial
mensagem_transmissor = zeros(1,tamanho_msg);
#ADD bit de dados na msg
j = 1;
for i = 0 : length(mensagem_transmissor)
    #verificar BITs q nao sao da base 2
    if mod(log2(i), 1) > 0 
        # Atribuir BITs de dados as posicoes
        mensagem_transmissor(i) = dados(j++); 
    endif
endfor
#ADD bit de erro na msg
for i = 1 : length(mensagem_transmissor)
    #verificar BITs q sao da base 2
    if mod(log2(i), 1) == 0 
        for j = i : length(mensagem_transmissor)
            # verificar quais BITs influenciarao no BIT de paridade
            if dec2bin(i)(1) == dec2bin(j)(length(dec2bin(j)) - length(dec2bin(i)) + 1)
                #XOR para o BIT de paridade
                mensagem_transmissor(i) = xor(mensagem_transmissor(i), mensagem_transmissor(j));
            endif
        endfor
    endif
endfor

#Meio de transmissão
mensagem_transmitida = mensagem_transmissor;

#Erro proposital
mensagem_transmitida(7) = !mensagem_transmitida(7);

#Receptor
#localizar provavel erro
posicao_erro = 0;
#indice dos BITs de paridade
bit_paridade = 0;
for i = 1 : length(mensagem_transmitida)
    #variavel para verificar se ha erro no BIT de paridade
    s = 0;
    #verificar BITs q sao da base 2
    if mod(log2(i), 1) == 0
        for j = i : length(mensagem_transmitida)
            # verificar quais BITs influenciarao no BIT de paridade
            if dec2bin(i)(1) == dec2bin(j)(length(dec2bin(j)) - length(dec2bin(i)) + 1)
                #XOR para localizar provavel erro
                s = xor(s, mensagem_transmitida(j));
            endif
        endfor
        #localizar posicao de provavel erro
        posicao_erro += 2^(bit_paridade)*s;
        bit_paridade++;
    endif
endfor

#corrigir o provavel erro
mensagem_corrigida = mensagem_transmitida;
if (posicao_erro != 0)
    #printar msg errada
    j = 1;
    for i = 1 : length(mensagem_corrigida)
        #verificar BITs q nao sao da base 2
        if (mod(log2(i)*1, 1) > 0) 
            mensagem_recebida(j++) = mensagem_corrigida(i);
        endif
    endfor
    disp(["mensagem errada:    " num2str(mensagem_recebida)])
    #localizar posicao relativa do erro na msg
    posicao_erro_relaivo = 0;
    for i = 1 : posicao_erro
        #verificar BITs q nao sao da base 2
        if (mod(log2(i)*1, 1) > 0) 
            posicao_erro_relaivo++;
        endif
    endfor
    disp(["Erro detectado na posicao " num2str(posicao_erro_relaivo)]);
    #corrigir erro
    mensagem_corrigida(posicao_erro) = !mensagem_corrigida(posicao_erro);
    #printar msg corrigida
    j = 1;
    for i = 1 : length(mensagem_corrigida)
        #verificar BITs q nao sao da base 2
        if (mod(log2(i)*1, 1) > 0) 
            mensagem_recebida(j++) = mensagem_corrigida(i);
        endif
    endfor
    disp(["mensagem corrigida: " num2str(mensagem_recebida)])
else
    #printar msg correta
    j = 1;
    for i = 1 : length(mensagem_corrigida)
        #verificar BITs q nao sao da base 2
        if (mod(log2(i)*1, 1) > 0) 
            mensagem_recebida(j++) = mensagem_corrigida(i);
        endif
    endfor
    disp(["mensagem recebida:  " num2str(mensagem_recebida)])
endif