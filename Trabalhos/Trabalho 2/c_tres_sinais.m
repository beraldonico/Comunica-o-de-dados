clear all
#VARIAVEIS EMISSOR E RECEPTOR
bitrate = 50;
tempo_por_bit = 1/bitrate;
tempo_por_amostra = 0.01*tempo_por_bit;
amostras_por_bit = tempo_por_bit/tempo_por_amostra;

#EMISSOR

datain(1,:) = [ 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1];
datain(2,:) = [ 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0];
datain(3,:) = [ 0 1 0 0 1 1 0 0 0 1 1 1 0 0 0 0 1 1 1 1 0 0 0 0 0 1 1 1 1 1 0 0 0 1 1 1];

tempo = 0 : tempo_por_amostra : tempo_por_bit * length(datain(:,:));
tempo = tempo(1 : (tempo_por_bit * length(datain(:, :))) / tempo_por_amostra);

for k = 1: length(datain(:,1))
    #CRIAR SINAL (signal)
    signal_length = 1;
    for i = 1 : length(datain(k,:))
        for j = 1 : amostras_por_bit
            if (datain(k, i) == 0)            
                signal(k, signal_length++) = 0;
            else
                signal(k, signal_length++) = 1;
            endif
        endfor
    endfor
    
    #FFT SIGNAL
    [f_signal(k,:), p_signal(k,:)] = fft_fun(signal(k,:), tempo_por_amostra);

    #CRIAR PORTADORA (portadora)
    freq_portadora(k) = k*100;
    portadora(k,:) = sin(2*pi*freq_portadora(k)*tempo);
    
    #FFT PORTADORA
    [f_portadora(k,:), p_portadora(k,:)] = fft_fun(portadora(k,:), tempo_por_amostra);

    #CRIAR SINAL MODULADO (sinal_modulado)
    sinal_modulado(k,:) = signal(k,:).*portadora(k,:);
    
    #FFT SINAL MODULADO
    [f_modulado(k,:), p_modulado(k,:)] = fft_fun(sinal_modulado(k,:), tempo_por_amostra);
endfor

#MULTIPLEXAÇÃO
sinal_multiplexado = sinal_modulado(1,:) + sinal_modulado(2,:) + sinal_modulado(3,:);

#RECEPTOR

for k = 1: length(datain(:,1))
    #DEMODULAR
    
    #DEMULTIPLEXAR(sinal_demultiplexado)
    fs = 1/tempo_por_amostra;
    cutoff_freq_low = (k - 1)*100 + 50;
    cutoff_freq_high = (k - 1)*100 + 150;
    freq_norm_low = 2*cutoff_freq_low/fs;
    freq_norm_high = 2*cutoff_freq_high/fs;
    [b, a] = butter(5, [freq_norm_low, freq_norm_high]);
    sinal_demultiplexado(k,:) = filter(b, a, sinal_multiplexado);
    
    #RETIFICAR(sinal_retificado)
    sinal_retificado(k,:) = abs(sinal_demultiplexado(k,:));

    #FILTRAR SINAL(sinal_filtrado)
    cutoff_freq = (bitrate/2) * 5;  #quinta harmonica
    freq_norm = 2*cutoff_freq/fs;
    [b, a] = butter(5, freq_norm);
    sinal_filtrado(k,:) = filter(b, a, sinal_retificado(k,:));

    #DEMODULAR(sinal_demodulado)
    for i = 1 : length(sinal_filtrado)
        if sinal_filtrado(k,i) >= max(sinal_filtrado(k,:))/2
            sinal_demodulado(k, i) = 1;
        else
            sinal_demodulado(k,i) = 0;
        endif
    endfor
endfor

for k = 1: length(datain(:,1))
    figure(k);

    #PLOT DO SINAL
    subplot(6,2,1);
    plot(tempo, signal(k,:), 'linewidth', 2);
    title('1 sinal digital');
    xlabel('tempo');

    #PLOT FFT DO SINAL
    subplot(6,2,2);
    plot(f_signal(k,:), p_signal(k,:), 'linewidth', 2);
    title('2 FFT sinal digital');
    xlabel('frequencia');
    
    #PLOT PORTADORA
    subplot(6,2,3);
    plot(tempo, portadora(k,:), 'linewidth', 2);
    title('3 portadora');
    xlabel('tempo');

    #PLOT FFT POTADORA
    subplot(6,2,4)
    plot(f_portadora(k,:),p_portadora(k,:), 'linewidth', 2);
    title('4 FFT portadora');
    xlabel('frequencia');

    #PLOT MODULADO
    subplot(6,2,5)
    plot(tempo, sinal_modulado(k,:), 'linewidth', 2)
    title('5 sinal modulado');
    xlabel('tempo');
    
    #PLOT FFT MODULADO
    subplot(6,2,6)
    plot(f_modulado(k,:), p_modulado(k,:), 'linewidth', 2)
    title('6 FFT sinal modulado');
    xlabel('frequencia');
    
    #PLOT MULTIPLEXADO
    subplot(6,2,7)
    plot(tempo, sinal_multiplexado, 'linewidth', 2)
    title('7 sinal multiplexado');
    xlabel('tempo');
    
    #PLOT DEMULTIPLEXADO
    subplot(6,2,8)
    plot(tempo, sinal_demultiplexado(k,:), 'linewidth', 2)
    title('8 sinal demultiplexado');
    xlabel('tempo');

    #PLOT RETIFICADO
    subplot(6,2,9)
    plot(tempo, sinal_retificado(k,:), 'linewidth', 2);
    title('9 sinal retificado');
    xlabel('tempo');

    #PLOT SINAL FILTRADO
    subplot(6,2,10)
    plot(tempo, sinal_filtrado(k,:), 'linewidth', 2),
    title('10 sinal filtrado');
    xlabel('tempo');

    #PLOT DEMODULADO
    subplot(6,2,11)
    plot(tempo, sinal_demodulado(k,:) , 'linewidth', 2)
    title('11 sinal demodulado');
    xlabel('tempo');
    
    #PLOT DATAIN E SAIDA
    subplot(6,2,12)
    plot(tempo, sinal_demodulado(k,:), 'r', 'linewidth', 4, tempo, signal(k,:), 'linewidth', 2)
    title('12 comparação entrada e saida');
    xlabel('tempo');
endfor