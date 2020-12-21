passo = 0.001;
t = 0:passo:1;

f1 = 1;
signal{1} = sin(2*pi*f1*t);

f2 = 2;
signal{2} = sin(2*pi*f2*t);

f3 = 3;
signal{3} = sin(2*pi*f3*t);

subplot(3,1,1)
stem(t,signal{1})

subplot(3,1,2)
stem(t,signal{2})

subplot(3,1,3)
stem(t,signal{3})


#keyboard

color='brgmkc';

ninputs = length(signal); 

tsample_in=passo;
nsamples_in=length(t);

tsample_m = tsample_in/3;                         

time_m = tsample_in:tsample_m:tsample_in*(nsamples_in)+tsample_in-tsample_m;  % time vector for multiplexed signal
for (i=1:ninputs)
  timeslots{i} = i:ninputs:(length(time_m));
end

figure     
hold on;
time_mm = time_m-tsample_in+tsample_m;
for (i=1:ninputs)
  stem(time_mm(timeslots{i}),signal{i},color(i));
end
xlim([tsample_m,time_m(end)]);
hold off;
