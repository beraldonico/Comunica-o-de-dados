clear all

data_in = [0 1 0 1 0 1 0 1 1 1 0 0 0];
#          + - - + + - - + - + + + +
amostra_por_bit = 100;
bitrate = 1000;
    
t_step = 1/(amostra_por_bit*bitrate);
tempo(1) = 0;
t = 0;
signal_length = 1;
steps_per_bit = ((1/bitrate)/t_step);
for i = 1 : length(data_in)
        if data_in(i) == 0
        for k = 1 : steps_per_bit
            if(signal_length == 1)
                signal(signal_length) = 5;
                tempo(signal_length++) = (t++)*t_step;
            else
                signal(signal_length) = signal(signal_length - 1);
                tempo(signal_length++) = (t++)*t_step;
            endif
        endfor
    elseif data_in(i) == 1
        if(signal(signal_length - 1) == 5)
            aux = -5;
        else
            aux = 5;
        endif
        for k = 1 : steps_per_bit
        if(signal_length == 1)
            signal(signal_length) = 5;
            tempo(signal_length++) = (t++)*t_step;
        else
            signal(signal_length) = aux;
            tempo(signal_length++) = (t++)*t_step;
        endif
        endfor
    endif
end

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
    for i = 1 : length(sinal_filtrado(k,:))
        if mod(i, steps_per_bit_receiver/2) == 0 && mod(i, steps_per_bit_receiver) != 0
            if i < steps_per_bit_receiver 
                if round(sinal_filtrado(k,i)) > 2.5
                    for j = 1 : steps_per_bit_receiver
                        signal_out(k, w++) = 0;
                    endfor
                else
                    for j = 1 : steps_per_bit_receiver
                        signal_out(k, w++) = 0;
                    endfor
                endif
            else
                if round(sinal_filtrado(k,i)) < round(sinal_filtrado(k, i - steps_per_bit_receiver)) ...
                || round(sinal_filtrado(k,i)) > round(sinal_filtrado(k, i - steps_per_bit_receiver))
                    for j = 1 : steps_per_bit_receiver
                        signal_out(k, w++) = 1;
                    endfor
                else
                    for j = 1 : steps_per_bit_receiver
                        signal_out(k, w++) = 0;
                    endfor
                endif
            endif
        endif
    endfor
endfor

for k = 1 : length(harmonicos)
    w = 1;
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
    grid minor
endfor
data_in
data_out