clear all

tempo_total = 1; %segundo
passo = tempo_total/100;

tempo = 0:passo:tempo_total 

for i = 1:length(tempo)
   y(i) = sin(2*pi*tempo(i));
end

plot(tempo,y);

