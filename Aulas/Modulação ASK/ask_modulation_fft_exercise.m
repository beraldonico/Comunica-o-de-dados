% CRIAR SINAL (y)
  bitrate = 50;
  tbit=1/bitrate;
  tsample = 0.01*tbit;
  passo = tsample;

%  bitstream = [ 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1]
  bitstream = [ 0 1 0 1 0 0 0 0 0 1 0 1 0 0 1 1 1 1 0 0 0 0 0 0 1 1 1 0 0 0 1 1 1 1 1 0]

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


  % CRIAR PORTADORA (c)
  % ...

  % CRIAR SINAL MODULADO (m)
  % ...

  % PLOTAR PORTADORA
  subplot(3,2,1)
  % ...

  % PLOTAR FFT DA PORTADORA
  subplot(3,2,2)
  % ...

  % PLOTAR SINAL
  subplot(3,2,3)
  % ...
  
  % PLOTAR FFT DO SINAL
  subplot(3,2,4)
  % ...

  % PLOTAR SINAL MODULADO
  subplot(3,2,5)
  % ...

  % PLOTAR FFT DO SINAL MODULADO
  subplot(3,2,6)
  % ...
