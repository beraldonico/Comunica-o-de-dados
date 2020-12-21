clear all

tempo_total = 1; %segundo
passo = 1/1000; %equivalente a freq. de amostragem em nosso caso;

%tempo = 0:passo:tempo_total;
tempo = 0:passo:tempo_total;
fsinal1 = 10;
fsinal2 = 3*fsinal1;

for i = 1:length(tempo)
      y(i) = 2.*sin(fsinal1*2*pi*tempo(i))+sin(fsinal2*2*pi*tempo(i));
end

subplot(1,2,1);
plot(tempo,y);

xlabel("tempo (segundos)");
ylabel("tensao");
title("Sinal");
grid

% Plot FFT
% https://www.mathworks.com/help/matlab/ref/fft.html
Y = fft(y);
L = size(Y,2); %length of signal
T = passo; %sampling period
Fs = 1/passo;
t = (0:L-1)*T; %time vector

%plot(t,values);
P2 = abs(Y/L); %two-sided spectrum
P1 = P2(1:L/2+1);             %single-sided spectrum
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;
subplot(1,2,2);
plot(f,P1);
xlabel("frequencia (Hertz)");