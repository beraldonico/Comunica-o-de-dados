% código para testar filtro no Octave 
t_step = 0.001;
total_time = 1;
t=0:t_step:1;


% sinal de entrada
finput = 100;
in=sin(2*pi*t*finput);



% criand coeficientes do filtro passa baixa
Fs=1/t_step;
cutoff_freq=10;
Fnorm=2*cutoff_freq/Fs;
[b,a]=butter(5,Fnorm);

% utilizando filtro
y=filter(b,a,in);

% plots
%subplot(2,1,1)
title("entrada"); 
plot(t,in,"r");
hold on
%subplot(2,1,2)
plot(t,y,"b");
legend({"entrada","saida"});