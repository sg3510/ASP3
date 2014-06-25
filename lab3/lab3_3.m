clear all;
clc;
close all;
addpath('voicebox');
N = 1;
Fs = 32768;
%generate phone numebrs
l_phone = floor(10*rand(N,11))
l_phone(:,1:3) = ones(N,1)*[0 2 0];
f1 = zeros(11,1);
f2 = zeros(11,1);
% assign frequencies
for i=1:11
    switch mod(l_phone(1,i),3)
        case 0
            f1(i) = 1477;
        case 1
            f1(i) = 1209;
        case 2
            f1(i) = 1366;
    end
    switch floor((l_phone(1,i)-1)/3)
        case 0
            f2(i) = 697;
        case 1
            f2(i) = 770;
        case 2
            f2(i) = 852;
    end
    %handle exception
    if l_phone(1,i) == 0
        f1(i) = 1336;
        f2(i) = 941;
    end
end
tone = zeros(1,180224);
%generate sound
for i=1:11
    
    for t=(1+Fs/2*(i-1)):(Fs/4*i + Fs*(i-1)/4)
         tone(t) = (sin(2*pi*f1(i)*(t)/Fs)+sin(2*pi*f2(i)*t/Fs))/2;
    end
    %silent section for 0.25 seconds
    for t=((1+Fs/4*i)+ Fs*(i-1)/4):Fs/2*i
         tone(t) = 0;
    end
end
figure(1);
i=1;
range = (1+Fs/2*(i-1)):(Fs/4*i + Fs*(i-1)/4);
plot(range,tone(range));hold all;
i=4;
range = (1+Fs/2*(i-1)):(Fs/4*i + Fs*(i-1)/4);
plot((1:Fs/4),tone(range),'r');hold off;
title('Tone generation 0 and 2')
xlabel('Time');
ylabel('Amplitude');
figure(2);
spgrambw(tone, Fs, 'Jcw',20,2000);
title('Tone generation for a random London Number')
% spectrogram(tone,hann(8192),0,512,Fs)
% view(-90,90)
% set(gca,'ydir','reverse')
% spectrogram(tone,Fs/4,Fs/4-40,256,Fs);%[S,F,T,P] = 
%surf(T,F,10*log10(P),'edgecolor','none'); axis tight; 

%xlabel('Time (Seconds)'); ylabel('Hz');
soundsc(tone,Fs)