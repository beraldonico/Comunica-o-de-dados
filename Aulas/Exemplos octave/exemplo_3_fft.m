clear all

tempo_total = 10; %segundo
passo = tempo_total/10000; %equivalente a freq. de amostragem em nosso caso;

tempo = 0:passo:tempo_total-passo;

for i = 1:length(tempo)
      y(i) = sin(2*pi*tempo(i));
end

%plot(tempo,y);

%xlabel("tempo (segundos)");
%ylabel("tensao");
%title("Sinal");
%grid


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
plot(f,P1);
