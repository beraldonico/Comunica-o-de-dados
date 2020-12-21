clear all

data_in = [0 1 0 1 0 1 0 1 1 1 0 0 0];
%          +- -+ +- -+ +- -+ +- -+ -+ -+ +- +- +-
amostra_por_bit = 100;
bitrate = 1000;
    
t_step = 1/(amostra_por_bit*bitrate);
tempo(1) = 0;
t = 0;
SL = 1;
steps_per_bit = ((1/bitrate)/t_step);
for i = 1 : length(data_in)
    if data_in(i) == 0
        for j = 1 : steps_per_bit
            if j < 51
                signal(SL) = 5;
                tempo(SL++) = (t++)*t_step;
            else
                signal(SL) = 0;
                tempo(SL++) = (t++)*t_step;
            endif
        endfor
    elseif data_in(i) == 1
        for j = 1 : steps_per_bit
            if j < 51
                signal(SL) = 0;
                tempo(SL++) = (t++)*t_step;
            else
                signal(SL) = 5;
                tempo(SL++) = (t++)*t_step;
            endif
        endfor
    endif
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
    w = 1;
    for i = steps_per_bit_receiver/4 : steps_per_bit_receiver : length(sinal_filtrado(k,:))
            if sinal_filtrado(k,i) < sinal_filtrado(k,i + steps_per_bit_receiver/2)
                for j = 1 : steps_per_bit_receiver
                    signal_out(k, w++) = 1;
                endfor
            elseif sinal_filtrado(k,i) > sinal_filtrado(k,i + steps_per_bit_receiver/2)
                for j = 1 : steps_per_bit_receiver
                    signal_out(k, w++) = 0;
                endfor
            endif
    endfor
    w = 1;
    for i = 1 : length(signal_out(k, :))
        if( mod(i, steps_per_bit_receiver/2) == 0 && mod(i, steps_per_bit_receiver) != 0)
            data_out(k, w++) = signal_out(k,i);
        endif
    endfor
    subplot(2, 3, k)
    plot(tempo, signal, 'linewidth', 2, tempo, signal_out(k,:), 'linewidth', 2, tempo, sinal_filtrado(k,:), 'linewidth', 2)
    #plot(tempo, signal, 'linewidth', 2, tempo, sinal_filtrado(k,:), 'linewidth', 2)
    xlabel("Tempo(S)")
    ylabel("Tensao(V)")
    title(k);
    grid minor
endfor
data_in
data_out