clear all;
clc;
close all;
addpath('voicebox');
order = 25;
N = 1;
Fs = 32768;
f1 = [1477 1209];
f2 = [697 941];
tone = zeros(1,Fs);
awgn = 0.00001*randn(Fs,1);
for i=1:2
    fprintf('start:%i   end:%i\n',(1+Fs/2*(i-1)),(Fs/4*i + Fs*(i-1)/4));
    for t=(1+Fs/2*(i-1)):(Fs/4*i + Fs*(i-1)/4)
         tone(t) = (sin(2*pi*f1(i)*(t)/Fs)+sin(2*pi*f2(i)*t/Fs))/2;
    end
    for t=((1+Fs/4*i)+ Fs*(i-1)/4):Fs/2*i
         tone(t) = 0;
    end
%     tone(i) = sin(2*pi*f1*i/Fs);
end
ptone = 0;
pnoise = 0;

for i = 1:length(tone)-1
    ptone = ptone + tone(i).^2;
    pnoise = pnoise + awgn(i).^2;
    tone(i) = tone(i) + awgn(i);
end
SNR = 10*log10(ptone/pnoise);
% plot((1:Fs/2*11)/Fs,tone)
figure(1);
plot((1:Fs)/Fs,tone)
figure(2);
xlabel('Time');
ylabel('Amplitude');
spgrambw(tone, Fs, 'Jcw',40,2000,60, [0 1]);
str = sprintf('3 and * tone generated with noise SNR=%2.2fdB',SNR);
title(str)
soundsc(tone,Fs)
ar_three = aryule(tone(1:8192),order);
ar_star = aryule(tone(16385:24576),order);
std_three = std(tone(1:8192));
std_star = std(tone(16385:24576));
figure;
[h,w] = freqz(std_three^2,ar_three,512,Fs);
subplot(2,1,1)
plot(w/(2*pi),abs(h).^2)
grid on
xlabel('Frequency');
ylabel('PSD Amplitude');
str = sprintf('PSd of 3 tone corrupted by noise SNR=%2.2fdB with an AR order of %d',SNR,order);
title(str)
subplot(2,1,2)
[h,w] = freqz(std_star^2,ar_star,512,Fs);
plot(w/(2*pi),abs(h).^2)
grid on
xlabel('Frequency');
ylabel('PSD Amplitude');
str = sprintf('PSd of * tone corrupted by noise SNR=%2.2fdB with an AR order of %d',SNR,order);
title(str)