clc;
Or = 1001;
x = randn(1,1000);
y=filter(ones(Or,1),[Or],x);
[a,b] = xcorr(y, 'unbiased');
subplot(2,1,1)
stem(b,a)
xlabel(' \tau (Time lag)')
ylabel('Amplitude')
str = sprintf('ACF of %dth Order MA filter 1000 AWGN samples',Or)
title(str)
axis ([-20 20 -2 8])
subplot(2,1,2)
plot(y)
xlabel(' Time')
ylabel('Amplitude')
str = sprintf('%dth Order MA filter 1000 AWGN samples',Or)
title(str)
y(1000)
mean(y)
%axis([0 200 -10 10])