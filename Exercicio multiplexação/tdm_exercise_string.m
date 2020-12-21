dados_canal{1} = "Cover me!                       ";
dados_canal{2} = "You take the point!             ";
dados_canal{3} = "Taking fire, need assistance!   ";

ninputs = length(dados_canal);
message_size = length(dados_canal{1});

# MULTIPLEXAÇÃO TDM
# transmitido = 
# "CYTooavuk..."
tx_idx=1;
for i=1:message_size
  for j=1:ninputs
    transmitido(tx_idx)=dados_canal{j}(i);
    tx_idx=tx_idx+1;
  endfor
endfor

recebido=transmitido;

input_idx=1;
message_idx=1;
for i=1:length(recebido)
  dados_canal_rx{input_idx}(message_idx)=recebido(i);
  input_idx=input_idx+1;
  if (input_idx>ninputs)
    input_idx=1;
    message_idx=message_idx+1;
  endif
endfor

#tx(i)=dados_canal{input_idx}(message_idx);

# DEMULTIPLEXAÇÃO
      
# dados_canal_rx{1} = ...
# dados_canal_rx{2}
# dados_canal_rx{3}
