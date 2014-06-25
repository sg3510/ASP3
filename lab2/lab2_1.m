clc;
x = randn(1,1000);
[a,b] = xcorr(x, 'unbiased');

stem([-999:1:999],a)
xlabel(' \tau (time lag)')
ylabel('Amplitude')
title('Unbiased auto-correation of 1000 AWGN samples')
axis([-50 50 -1 1.5])