pkg load signal
    % CRIAR SINAL (y)
    bitrate = 50;
    tbit=1/bitrate;
    tsample = 0.01*tbit;
    passo = tsample;
    Fs = 1/tsample;
    %bitstream = [ 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1]
    bitstream = [ 0 1 0 1 0 0 0 0 0 1 0 1 0 0 1 1 1 1 0 0 0 0 0 0 1 1 1 0 0 0 1 1 1 1 1 0]

    t=0:tsample:tbit*length(bitstream);

    t = t(1:end-1);
    samples_per_bit = tbit/tsample;

    k=1;
    for i=1:length(bitstream)
	for j=1:samples_per_bit
	    if (bitstream(i)==0)            
		y(k) = -1;
	    else
		y(k) = 1;
	    end
	    k=k+1;
	end
    end


    % CRIAR PORTADORA DO SINAL DE ORIGEM (c)

    % CRIAR SINAL MODULADO (m)

    % DEMODULAR

    %for i=1:length(m)
        % VCO
        % phase detector
	% low pass
    %end

    % PLOTAR SINAL DE ENTRADA
    subplot(4,2,1)

    % PLOTAR VALOR MODULADO
    subplot(4,2,2)

    % PLOTAR SAÍDA DO DETECTOR DE FASE
    subplot(4,2,3)

    % PLOTAR SAÍDA DO FILTRO
    subplot(4,2,4)

    % PLOTAR SAÍDA DO VCO
    subplot(4,2,5)
    plot(t,vco)

    % PLOTAR VALOR DEMODULADO
    subplot(4,2,6)
