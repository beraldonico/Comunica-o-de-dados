pkg load signal

passo = 1e-5; %passo da simulação
tempo_total = 10;  % tempo da simulação (em segundos)
t = 0:passo:tempo_total;

% CRIAR SINAL (y)
[Y,wav_fs] = wavread("piano2.wav");
ywav = Y(:,1); % pegar só um canal
%y = Y(1:30000,1); % pegar primeiros valores (caso haja problemas de memória em pegar todos) e só um canal;
ywav = ywav'; 
wav_passo = 1/wav_fs;
twav = 0:wav_passo:wav_passo*(length(ywav)-1);

% converter para passo do WAV para passo da simulação
k = 1;
for i=1:length(t) 
    if (k>=length(ywav))
       y(i) = 0;
    else
        if (twav(k) < t(i))
      	    k = k + 1;
        end  
        y(i) = ywav(k);
    end
end

% Restringir sinal a aprox. 2 kHz
% ...

% CRIAR PORTADORA (c)
% ...

% CRIAR SINAL MODULADO (m)
% ...

% PLOTAR PORTADORA
% subplot(3,2,1)
% ...
% subplot(3,2,2)
% ...

% PLOTAR SINAL
% subplot(3,2,3)
% ...
% subplot(3,2,4)
% ...

% PLOTAR SINAL MODULADO
% subplot(3,2,5)
% ...
% subplot(3,2,6)
% ...
