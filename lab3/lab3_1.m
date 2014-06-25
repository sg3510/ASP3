clc;
clear all;
close all;
x=randn(1024,1);
c=zeros(128,8);
for i=1:8
    [c(:,i),~] = pgm(x((i-1)*128+1:128*i)');
end
c = mean(c');
%%
[a,b]=pgm(c);
figure(1);
stem(c,'.')
axis tight;
str = sprintf('Periodogram of AWGN average of 8 sample sets');
title(str);
figure(2);

%filtfilt(0.2*[1 1 1 1 1],1,a); %used for 3.1.1
for i=1:8
    subplot(8,1,i)
[a,b]=pgm(x((i-1)*128+1:128*i)');
stem(a,'.')
axis tight;
str = sprintf('Periodogram of AWGN for N=%d to %d',(i-1)*128+1,128*i);
title(str);
end
xlabel('Time/Sample');
ylabel('Amplitude')