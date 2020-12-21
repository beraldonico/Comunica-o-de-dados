bitstream{1} = [ 0 1 0 1];
bitstream{2} = [ 1 0 1 1];
bitstream{3} = [ 1 1 0 1];


bitrate = 50;

tbit_in = 1/bitrate

message_size = length(bitstream{1});
t = tbit_in:tbit_in:message_size*tbit_in;

subplot(3,1,1)
stem(t,bitstream{1})

subplot(3,1,2)
stem(t,bitstream{2})

subplot(3,1,3)
stem(t,bitstream{3})

# time_in = ..... baseado no bitrate


# Multiplexação

# bitstream_de_saída = ...
# time_tx = ...

# Demultiplexação
