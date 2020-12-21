clear all
clc

% código para testar filtro no Octave 
t_step = 0.001;
t=0:t_step:10;
%keyboard

% sinal de entrada
finput = 10;
in=sin(2*pi*t*finput);


% criand coeficientes do filtro passa baixa
Fs=1/t_step;
cutoff_freq=10;
Fnorm=2*cutoff_freq/Fs;
[b,a]=butter(5,Fnorm);

% utilizando filtro
y=filter(b,a,in);

plot(t,y, t,in);