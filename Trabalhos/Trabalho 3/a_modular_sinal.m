clear all
bitrate = 50;
tempo_por_bit = 1/bitrate;
tempo_por_amostra = 0.01*tempo_por_bit;

datain = [ 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1];

tempo = 0 : tempo_por_amostra : tempo_por_bit * length(datain);
tempo = tempo(1 : (tempo_por_bit * length(datain)) / tempo_por_amostra);
amostras_por_bit = tempo_por_bit/tempo_por_amostra;

#CRIAR SINAL (signal)
signal_length = 1;
for i = 1 : length(datain)
    for j = 1 : amostras_por_bit
        if (datain(i) == 0)            
            signal(signal_length++) = -1;
        else
            signal(signal_length++) = 1;
        endif
    endfor
endfor

figure('name', 'Trabalho 3');

#PLOT DO SINAL
subplot(4,2,1)
plot(tempo, signal, 'linewidth', 2)
grid;
title('1 sinal digital');
xlabel('tempo');

#FFT DO SINAL E PLOT DO MESMO
subplot(4,2,2)
[f_y, P_y] = fft_fun(signal, tempo_por_amostra);
plot(f_y, P_y, 'linewidth', 2)
grid;
title('2 FFT do sinal digital');
xlabel('frequencia')

#CRIAR PORTADORA E PLOT DO MESMO (portadora)
freq_portadora = 200;
delta_freq = 100;
portadora_0 = sin(2*pi*(freq_portadora - delta_freq)*tempo);
portadora_1 = sin(2*pi*(freq_portadora + delta_freq)*tempo);
subplot(4,2,3)
plot(tempo, portadora_0, 'linewidth', 2);
grid;
title('3 portadora quando 0');
xlabel('tempo');
subplot(4,2,5)
plot(tempo, portadora_1, 'linewidth', 1);
grid;
title('5 portadora quando 1');
xlabel('tempo');

#FFT DA PORTADORA E PLOT DO MESMO
[f_c0, P_c0] = fft_fun(portadora_0, tempo_por_amostra);
[f_c1, P_c1] = fft_fun(portadora_1, tempo_por_amostra);
subplot(4,2,4)
plot(f_c0, P_c0, 'linewidth', 2)
grid;
title('4 FFT portadora');
xlabel('frequencia')
subplot(4,2,6)
plot(f_c1, P_c1, 'linewidth', 2)
grid;
title('6 FFT portadora');
xlabel('frequencia')

#CRIAR SINAL MODULADO E PLOT DO MESMO(sinal_modulado)
delta_freq = 100;
for i = 1 : length(signal)
    if signal(i) <= 0
        sinal_modulado(i) = sin(2*pi*tempo(i)*(freq_portadora - delta_freq));
    else
        sinal_modulado(i) = sin(2*pi*tempo(i)*(freq_portadora + delta_freq));
    endif
endfor
subplot(4,2,7)
plot( tempo, sinal_modulado, 'linewidth', 1)
grid;
title('7 sinal modulado');
xlabel('tempo');

#FFT DO SINAL MODULADO E PLOT DO MESMO
subplot(4,2,8)
[f_m, P_m] = fft_fun(sinal_modulado, tempo_por_amostra);
plot(f_m, P_m, 'linewidth', 2)
grid;
title('8 FFT sinal modulado');
xlabel('frequencia')

