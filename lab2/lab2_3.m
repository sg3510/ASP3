clc;
Or = 9;
x = randn(1,1000);
y=filter(ones(Or,1),[1],x);
[a,b] = xcorr(y,x, 'unbiased');
stem(b,a)
xlabel(' \tau (Time lag)')
ylabel('Amplitude')
str = sprintf('Cross Correlation of %dth Order MA filter fo 1000 AWGN samples with non-filtered samples',Or)
title(str)
axis ([-20 20 -1 3])