clear all

#Transmissor
#criacao de texto
texto = "This is a message";
#texto = "opa";
disp(["mensagem enviada: " texto])
mensagem_texto = double(texto);
for q = 1 : length(mensagem_texto(1,:))
    #converter char em bin
    mensagem_binaria = dec2bin(mensagem_texto(1,q));
    
    #Verificar quantos BITs são necessarios
    R = 0;
    do
        R++;
    until(2^R >= length(mensagem_binaria) + R + 1)
    #soma do tamnnho de texto e da quantidade de BITs de paridade
    tamanho_msg = length(mensagem_binaria) + R;
    
    #Criar msg
    #zerar msg inicial
    mensagem_transmissor = zeros(1,tamanho_msg);
    #ADD bit de texto na msg
    j = 1;
    for i = 1 : length(mensagem_transmissor)
        #verificar BITs q nao sao da base 2
        if mod(log2(i), 1) > 0 
            # Atribuir BITs de texto as posicoes
            mensagem_transmissor(i) = str2num(mensagem_binaria(j++)); 
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
    mensagem_transmitida(3) = !mensagem_transmitida(3);

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
    #texto com erro ou sem erro
    j = 1;
    for i = 1 : length(mensagem_corrigida)
        #verificar BITs q nao sao da base 2
        if mod(log2(i), 1) > 0 
            # Atribuir BITs de texto as posicoes
            texto_aux(j++) = num2str(mensagem_corrigida(i)); 
        endif
    endfor
    texto_errado(1,q) = bin2dec(num2str(texto_aux));
    if (posicao_erro != 0)
        #informar qual letra tem erro
        disp(["Erro detectado na letra de posicao " num2str(q)]);
        #corrigir erro
        mensagem_corrigida(posicao_erro) = !mensagem_corrigida(posicao_erro);
    endif
    #texto sem erro
    j = 1;
    for i = 1 : length(mensagem_corrigida)
        #verificar BITs q nao sao da base 2
        if mod(log2(i), 1) > 0 
            # Atribuir BITs de texto as posicoes
            texto_aux(j++) = num2str(mensagem_corrigida(i)); 
        endif
    endfor
    texto_double(1,q) = bin2dec(num2str(texto_aux));
    clear texto_aux;
endfor
disp(["mensagem com possivel erro: " char(texto_errado)]);
disp(["mensagem correta: " char(texto_double)]);