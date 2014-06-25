clc;
%% Plot periodogram
if ~exist('s2h','var')
    load vinyl.mat
end
Fs=44100;
figure(1);
Hs=spectrum.periodogram;	     % Use default values
psd(Hs,s2h_original(:,2),'Fs',Fs)
%% filter
data=s2h;
[b,a]=butter(3, [1420 1560]/Fs*2, 'stop');
data = filtfilt(b,a,data); %filtfilt used instead of filter to avoid change in phase
[b,a]=butter(3, [150 250]/Fs*2, 'stop');
data(:,2) = filtfilt(b,a,data(:,2));
%plot fft of difference
l = length(data);
plot((1:l)*Fs/l,abs(fft(data-s2h_original)))
title('Spectrum (FFT) of difference between data and orignal');
ylabel('Amplitude')
xlabel('Frequency')
axis([0 2000 0 500])
%% play
a = audioplayer(data,Fs);
% play(a);
%% clean periodogram
[periodgm1,w] = periodogram(s2h_original(:,2),[],[],Fs);
figure;
plot(w,periodgm1);
%% 4.1.4 Plot periodograms
figure(4);
% Hs=spectrum.periodogram;	     % Use default values
[periodgm1,w] = periodogram(data(:,1),[],[],Fs);
[periodgm2,w] = periodogram(data(:,2),[],[],Fs);
[periodgm3,w] = periodogram(s2h(:,1),[],[],Fs);
[periodgm4,w] = periodogram(s2h(:,2),[],[],Fs);
[periodgm5,w] = periodogram(s2h_original(:,1),[],[],Fs);
[periodgm6,w] = periodogram(s2h_original(:,2),[],[],Fs);

subplot(3,1,1)
plot(w,periodgm1);hold on;
plot(w,periodgm2,'r');hold off;
title('Periodogram of data')
ylabel('Amplitude')
axis([0 2000 0 4*10^-4]);
legend('Processed data Channel 1','Processed data Channel 2');
axis([0 2000 0 4*10^-4]);

subplot(3,1,2)
plot(w,periodgm3);hold on;
plot(w,periodgm4,'g');hold off;
axis([0 2000 0 4*10^-4]);
legend('original Corrupted data Channel 1','original Corrupted data Channel 2');
axis([0 2000 0 4*10^-4]);
ylabel('Amplitude')

subplot(3,1,3)
plot(w,periodgm5);hold on;
plot(w,periodgm6,'r');hold off;
axis([0 2000 0 4*10^-4]);
legend('original clean data Channel 1','original clean data Channel 2');
axis([0 2000 0 4*10^-4]);
ylabel('Amplitude')
xlabel('Frequency')
%% 4.1.4 Plot data diff
figure(5);
% Hs=spectrum.periodogram;	     % Use default values
[periodgm1,~] = periodogram(data(:,1),[],[],Fs);
[periodgm2,~] = periodogram(data(:,2),[],[],Fs);
[periodgm3,~] = periodogram(s2h_original(:,1),[],[],Fs);
[periodgm4,w] = periodogram(s2h_original(:,2),[],[],Fs);
re_1 = abs(norm(periodgm3 - periodgm1)/norm(periodgm3));
re_2 = abs(norm(periodgm4 - periodgm2)/norm(periodgm4));
fftdiff_1 = abs(fft(data(:,1)-s2h_original(:,1)));
fftdiff_2 = abs(fft(data(:,2)-s2h_original(:,2)));
w= (1:length(fftdiff_1))*Fs/length(fftdiff_1);
clf(5);
hold all;
plot(w,fftdiff_1);
plot(w,fftdiff_2);
str = sprintf('\\bf{FFT of difference of Filtered and Clean}\n\\rm{Relative Error RE_1=%f RE_2=%f}',re_1,re_2);
title(str)
axis([0 2500 0 70]);
ylabel('Amplitude');
xlabel('Freqeuncy (Hz)')
legend('Difference in channel 1','Difference in channel 2');