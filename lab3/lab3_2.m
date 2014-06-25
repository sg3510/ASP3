clc;
clear all;

figure(1)
x=randn(1064,1);
y=filter([1],[1 0.9],x);
y=y(41:1064);
x=x(41:1064);
subplot(2,1,1)
plot(x)
xlabel('Sample #')
ylabel('Amplitude')
axis tight;
str = sprintf('Original Unfiltered Signal');
title(str);
subplot(2,1,2)
plot(y)
xlabel('Sample #')
ylabel('Amplitude')
axis tight;
str = sprintf('Filtered Signal');
title(str);
[h,w]=freqz([1],[1 0.9],512);
figure(2)
py = pgm(y');
plot(w/(2*pi),abs(h).^2); hold on;
plot(w/(2*pi),py(1:512),'r');hold off;
legend('Ideal PSD','Periodogram of Y (i.e. estimated PSD)')
xlabel('Normalized Frequency (rad)')
ylabel('Amplitude')
axis tight;
grid on;
str = sprintf('PSD of filter');
title(str);
%% plot estimate
corry = xcorr(y,'unbiased');
%calculate a and sigma
a1 = -corry(2)/corry(1);
sigma_x = corry(1)+a1*corry(2);
%sigma_x = var(x); %alternative to line above
figure(3);
%get the data
[h,w]=freqz(sigma_x,[1 a1],512);
%plot estimate with model
plot(w/(2*pi),abs(h).^2); hold on;
plot(w/(2*pi),py(1:512),'r');hold off;
legend('Estimated','Periodogram of Y (i.e. estimated PSD)')
xlabel('Normalized Frequency (rad)')
ylabel('Amplitude')
axis tight;
grid on;
str = sprintf('Estimated PSD of AR(1)\n \\sigma_x = %f a_1=%f',abs(sigma_x),a1);
title(str);
% [a,b]=pgm(x((i-1)*128+1:128*i)');
% %filtfilt(0.2*[1 1 1 1 1],1,a);
% plot(a)
% axis tight;
% str = sprintf('Periodogram of AWGN for N=%d to %d',(i-1)*128+1,128*i);
% title(str);