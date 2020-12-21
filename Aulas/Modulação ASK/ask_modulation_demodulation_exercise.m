pkg load signal
   % CRIAR SINAL (y)
    bitrate = 50;
    tbit=1/bitrate;
    tsample = 0.01*tbit;
    passo = tsample;

    bitstream = [ 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1]
  %  bitstream = [ 0 1 0 1 0 0 0 0 0 1 0 1 0 0 1 1 1 1 0 0 0 0 0 0 1 1 1 0 0 0 1 1 1 1 1 0]

    t=0:tsample:tbit*length(bitstream);

    t = t(1:end-1);
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


    % CRIAR PORTADORA DO SINAL DE ORIGEM (c)
    % ...

    % CRIAR SINAL MODULADO (m)
    % ...

    % DEMODULAR (d)   
    % ...
