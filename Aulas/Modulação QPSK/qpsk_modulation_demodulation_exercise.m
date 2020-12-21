% CRIAR SINAL (y)
bitrate = 50;
tbit=1/bitrate;
tsample = 0.01*tbit;
passo = tsample;

%bitstream = [ 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1]
bitstream = [ 0 1 0 1 0 0 0 0 0 1 0 1 0 0 1 1 1 1 0 0 0 0 0 0 1 1 1 0 0 0 1 1 1 1 1 0]

%***********
% MODULAR
%***********

% CONVERSOR SERIAL PARALELO
t=0:tsample:tbit*length(bitstream)/2;
t = t(1:end-1);

samples_per_bit = tbit/tsample;

k=1;
for i=1:length(bitstream)/2
    for j=1:samples_per_bit
        % bit 1
        if (bitstream(i)==0)            
            y1(k) = -1;
        else
            y1(k) = 1;
        end
        % bit 2
        if (bitstream(i+1)==0)            
            y2(k) = -1;
        else
            y2(k) = 1;
        end	      
        k=k+1;
      end
  end

% CRIAR PORTADORA EM FASE PARA MODULAÇÃO (ci)

% CRIAR PORTADORA EM QUADRATURA PARA MODULAÇÃO (cq)

% CRIAR SINAL MODULADO EM FASE (mi)

% CRIAR SINAL MODULADO EM QUADRATURA (mq)

% CRIAR SINAL MODULADO FINAL (SOMA DO MODULADO EM QUADRATURA E DO MODULADO EM QUADRATURA)

%***********
% DEMODULAR
%***********

% CRIAR PORTADORA EM FASE PARA DEMODULAÇÃO (ci_rx)

% CRIAR PORTADORA EM QUADRATURA PARA MODULAÇÃO (cq_rx)

% MISTURADOR (MIXER) PARA SINAL EM FASE

% MISTURADOR (MIXER) PARA SINAL EM QUADRATURA

% PASSA BAIXAS PARA MIXER DO SINAL EM FASE

% PASSA BAIXAS PARA MIXER DO SINAL EM QUADRATURA

% COMPARADORES

% CONVERSOR PARALELO SERIAL

%***********
% PLOTS
%***********

% PLOTAR SINAL DE ENTRADA (parte 2)

% PLOTAR VALOR MODULADO

% PLOTAR SAÍDA DO MIXER COM OSCILADOR EM FASE (mixer_i)

% PLOTAR SAÍDA DO MIXER COM OSCILADOR EM QUADRATURA (mixer_q)

% PLOTAR SAÍDA DO FILTRO PB PARA SINAL EM FASE (filtered_i)

% PLOTAR SAÍDA DO FILTRO PB PARA SINAL EM QUADRATURA (filtered_q)

% PLOTAR VALOR DEMODULADO
