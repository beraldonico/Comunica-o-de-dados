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

#CRIAR PORTADORA E PLOT DO MESMO (portadora)
freq_portadora = 200;
delta_freq = 100;
amplitude = 5;
portadora_0 = amplitude*sin(2*pi*(freq_portadora - delta_freq)*tempo);
portadora_1 = amplitude*sin(2*pi*(freq_portadora + delta_freq)*tempo);
subplot(4,2,2)
plot(tempo, portadora_0, 'linewidth', 2);
grid;
title('2 portadora quando 0');
xlabel('tempo');
subplot(4,2,3)
plot(tempo, portadora_1, 'linewidth', 1);
grid;
title('3 portadora quando 1');
xlabel('tempo');

#CRIAR SINAL MODULADO E PLOT DO MESMO(sinal_modulado)
for i = 1 : length(signal)
    if signal(i) <= 0
        sinal_modulado(i) = portadora_0(i);
    else
        sinal_modulado(i) = portadora_1(i);
    endif
endfor
subplot(4,2,4)
plot( tempo, sinal_modulado, 'linewidth', 1)
grid;
title('4 sinal modulado');
xlabel('tempo');

% DEMODULAR
sinal_filtrado(1) = 0;
for i = 1 : length(sinal_modulado)
    % VCO
    fvco = freq_portadora+delta_freq*10*sinal_filtrado(i);
    vco(i) = sin(2*pi.*fvco.*tempo(i));

    % phase detector
    input_pll(i) = (sinal_modulado(i)>=0); %only 1 or 0
    vco_abs(i) = (vco(i)>=0); %only 1 or 0
    phase_detector(i) = vco_abs(i)-input_pll(i);

    % low pass
    sinal_filtrado(i+1) = 1*sinal_filtrado(i) + 0.1*(phase_detector(i));
end
sinal_filtrado = sinal_filtrado(1:end-1);

sinal_demodulado = (sinal_filtrado>0);

% PLOTAR SAÍDA DO DETECTOR DE FASE
subplot(4,2,5)
plot(tempo, phase_detector, 'linewidth', 2);
grid;
title('5 detector de fase');
xlabel('tempo');

% PLOTAR SAÍDA DO FILTRO
subplot(4,2,6)
plot(tempo, sinal_filtrado, 'linewidth', 2);
grid;
title('6 sinal filtrado');
xlabel('tempo');

% PLOTAR SAÍDA DO VCO
subplot(4,2,7)
plot(tempo,vco, 'linewidth', 1)
grid;
title('7 VCO');
xlabel('tempo');

% PLOTAR VALOR DEMODULADO
subplot(4,2,8)
plot(tempo, sinal_demodulado, 'linewidth', 2);
grid;
title('8 sinal demodulado');
xlabel('tempo');