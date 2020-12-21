clear all
bitrate = 50;
tempo_por_bit = 1/bitrate;
tempo_por_amostra = 0.01*tempo_por_bit;

datain = [ 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1];

tempo = 0 : tempo_por_amostra : tempo_por_bit * length(datain);
tempo = tempo(1 : (tempo_por_bit * length(datain(:, :))) / tempo_por_amostra);
amostras_por_bit = tempo_por_bit/tempo_por_amostra;

#CRIAR SINAL (signal)
signal_length = 1;
for i = 1 : length(datain)
    for j = 1 : amostras_por_bit
        if (datain(i) == 0)            
            signal(signal_length++) = 0;
        else
            signal(signal_length++) = 1;
        endif
    endfor
endfor

figure('name', 'Trabalho 2');

#PLOT DO SINAL
subplot(3,2,1)
plot(tempo, signal, 'linewidth', 2)
title('1 sinal digital');
xlabel('tempo');

#CRIAR PORTADORA E PLOT DO MESMO (portadora)
freq_portadora = 100;
amplitude_portadora = 5;
portadora = amplitude_portadora * sin(2*pi*freq_portadora*tempo);
subplot(3,2,2)
plot(tempo, portadora, 'linewidth', 2);
title('2 portadora');
xlabel('tempo');

#CRIAR SINAL MODULADO E PLOT DO MESMO(sinal_modulado)
sinal_modulado = signal.*portadora;
subplot(3,2,3)
plot( tempo, sinal_modulado, 'linewidth', 2)
title('3 sinal modulado');
xlabel('tempo');

#DEMODULAR
#RETIFICAR(sinal_retificado)
sinal_retificado = abs(sinal_modulado);
subplot(3,2,4)
plot(tempo, sinal_retificado, 'linewidth', 2);
title('4 sinal retificado');
xlabel('tempo');

#FILTRAR SINAL(sinal_filtrado)
fs = 1/tempo_por_amostra;
cutoff_freq = 200;
freq_norm = 2*cutoff_freq/fs;
[b, a] = butter(5, freq_norm);
sinal_filtrado = filter(b, a, sinal_retificado);
subplot(3,2,5)
plot(tempo, sinal_filtrado, 'linewidth', 2),
title('5 sinal filtrado');
xlabel('tempo');

#DEMODULAR(sinal_demodulado)
sinal_demodulado = zeros(1, length(sinal_filtrado));
sinal_demodulado(sinal_filtrado > 1) = 1;

%mostrar
subplot(3,2,6)
plot(tempo, sinal_demodulado , 'linewidth', 2)
title('6 sinal demodulado');
xlabel('tempo');