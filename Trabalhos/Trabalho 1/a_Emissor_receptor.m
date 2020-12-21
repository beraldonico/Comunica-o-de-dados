clear all

data_in = [0 1 0 1 0 1 0 1 1 1 0 0 0];
amostra_por_bit = 100;
bitrate = 1000;
    
t_step = 1/(amostra_por_bit*bitrate);
tempo(1) = 0;
t = 0;
signal_length = 1;
steps_per_bit = ((1/bitrate)/t_step);
for i = 1 : length(data_in)
    for k = 1 : steps_per_bit
        if data_in(i) == 0
            signal(signal_length) = 0;
        else
            signal(signal_length) = 5;
        endif
        tempo(signal_length++) = (t++)*t_step;
    endfor
endfor

Fs=1/t_step;
freq_fundamental = bitrate/2;
harmonicos = [freq_fundamental/2 freq_fundamental 3*freq_fundamental 5*freq_fundamental 7*freq_fundamental 9*freq_fundamental];
for k = 1 : length(harmonicos)
    cutoff_freq = harmonicos(k);
    Fnorm = 2*cutoff_freq/Fs;
    [b,a] = butter(5, Fnorm);
    sinal_filtrado(k,:) = filter(b, a, signal);
endfor

figure('name', 'Comparação entrada, filtrada e saida');

steps_per_bit_receiver=((1/bitrate)/t_step);
for k = 1 : length(harmonicos)
    for i=1 : length(sinal_filtrado(k,:))
        w = 1;
        if( sinal_filtrado(k,i) > 2.5)
            signal_out(k,i)=1;
        else
            signal_out(k,i)=0;
        endif
    endfor
    for i = 1 : length(signal_out(k, :))
        if( mod(i, steps_per_bit_receiver/2) == 0 && mod(i, steps_per_bit_receiver) != 0)
            data_out(k, w++) = signal_out(k,i);
        endif
    endfor
    subplot(2, 3, k)
    plot(tempo, signal, 'linewidth', 2, tempo, signal_out(k,:), 'linewidth', 2, tempo, sinal_filtrado(k,:), 'linewidth', 2)
    xlabel("Tempo(S)")
    ylabel("Tensao(V)")
    title(k);
    grid
endfor
data_in
data_out