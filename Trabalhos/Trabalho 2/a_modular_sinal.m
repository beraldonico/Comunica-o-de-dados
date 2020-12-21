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

#FFT DO SINAL E PLOT DO MESMO
subplot(3,2,2)
[f_y, P_y] = fft_fun(signal, tempo_por_amostra);
plot(f_y, P_y, 'linewidth', 2)
title('2 FFT do sinal digital');
xlabel('frequencia')

#CRIAR PORTADORA E PLOT DO MESMO (portadora)
freq_portadora = 100;
portadora = sin(2*pi*freq_portadora*tempo);
subplot(3,2,3)
plot(tempo, portadora, 'linewidth', 2);
title('3 portadora');
xlabel('tempo');

#FFT DA PORTADORA E PLOT DO MESMO
subplot(3,2,4)
[f_c, P_c] = fft_fun(portadora, tempo_por_amostra);
plot(f_c, P_c, 'linewidth', 2)
title('4 FFT portadora');
xlabel('frequencia')

#CRIAR SINAL MODULADO E PLOT DO MESMO(sinal_modulado)
sinal_modulado = signal.*portadora;
subplot(3,2,5)
plot( tempo, sinal_modulado, 'linewidth', 2)
title('5 sinal modulado');
xlabel('tempo');

#FFT DO SINAL MODULADO E PLOT DO MESMO
subplot(3,2,6)
[f_m, P_m] = fft_fun(sinal_modulado, tempo_por_amostra);
plot(f_m, P_m, 'linewidth', 2)
title('6 FFT sinal modulado');
xlabel('frequencia')