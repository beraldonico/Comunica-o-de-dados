clear all

bitrate = 1;
tbit=1/bitrate;
tsample = 0.01*tbit;
passo = tsample;

bitstream = [ 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1]
%bitstream = [ 0 1 0 1 0 0 0 0 0 1 0 1 0 0 1 1 1 1 0 0 0 0 0 0 1 1 1 0 0 0 1 1 1 1 1 0]
%bitstream = [ 1 1 1 1 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 0 1 1 1 1 1 0 0 0 0 1 1 1]
%bitstream = [0 1]

tempo=0:tsample:tbit*length(bitstream);

tempo = tempo(1:end-1);
samples_per_bit = tbit/tsample;

k=1;
for i=1:length(bitstream)
    for j=1:samples_per_bit
        if (bitstream(i)==0)            
            y(k) = 0;
        else
            y(k) = 1;
        end
        k=k+1;
    end
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

set(gca, 'XScale', 'log')
grid minor
