%% Adaptation from part 4.1.5 NLMS
clc;
LMS = 0;
p1=2;
p2=p1;
mu1=.4;
mu2=mu1;
x1=um(1:end/10,1);
x2=um_original(1:end/10,2);
N = length(x1);
w1 = zeros(N,p1);
w2 = zeros(N,p2);
e1 = zeros(N,1);
e2 = zeros(N,1);
y_h1 = zeros(N,1);
y_h2 = zeros(N,1);
y1 = um_original(:,1);
y2 = um_original(:,2);
n1 = zeros(N,1);
n2 = zeros(N,1);
for i = p1+1:N
    y_h1(i) = w1(i,:)*x1(i-1:-1:i-p1);
    e1(i) = y1(i) - y_h1(i);
    n1(i) = x1(i-1:-1:i-p1)'*x1(i-1:-1:i-p1);
    if LMS == 1
        n1(i) = 1;
    end
    if n1(i) <= 0
        w1(i+1,:) = w1(i,:);
    else
        w1(i+1,:) = w1(i,:) + mu1*e1(i)*x1(i-1:-1:i-p1)'./n1(i);
    end
end
%% bit here
for i = p2+1:N
    y_h2(i) = w2(i,:)*x2(i-1:-1:i-p2);
    e2(i) = y2(i) - y_h2(i);
    n2(i) = x2(i-1:-1:i-p2)'*x2(i-1:-1:i-p2);
    if LMS == 1
        n2(i) = 1;
    end
    if n2(i) <= 0
        w2(i+1,:) = w2(i,:);
    else
        w2(i+1,:) = w2(i,:) + mu2*e2(i)*x2(i-1:-1:i-p2)'./n2(i);
    end
end
disp('Done! :)')
%% fig
Fs = 44100;
%calculate relative error
[periodgm1,~] = periodogram(y_h1,[],[],Fs);
[periodgm2,~] = periodogram(y_h2,[],[],Fs);
[periodgm3,~] = periodogram(um_original(1:N,1),[],[],Fs);
[periodgm4,w] = periodogram(um_original(1:N,2),[],[],Fs);
re_1 = abs(norm(periodgm3 - periodgm1)/norm(periodgm3))
re_2 = abs(norm(periodgm4 - periodgm2)/norm(periodgm4))
%%%%%%%%%%%%%%%%%%%
figure(1);
subplot(2,1,1);
plot(w1);
str = sprintf('\\bf{Filter coefficients over time} \\rm{NLMS Filter for p_1=%d p_2=%d and \\mu_1=%f \\mu_2=%f}\nRelative Error RE_1=%f   RE_2=%f',p1,p2,mu1,mu2,re_1,re_2);
title(str);
ylabel('Channel 1')
subplot(2,1,2);
plot(w2);
ylabel('Channel 2')
xlabel('Time')
figure(2)
plot([1:length(y_h1)]*FS/length(y_h1),abs(fft(y_h1))-abs(fft(um_original(1:N,1))))
str = sprintf('FFT of difference of magnitude of estimated and clean signal Channel 1 p_1=%d p_2=%d \\mu_1=%f \\mu_2=%f',p1,p2,mu1,mu2);
title(str)
ylabel('Amplitude')
xlabel('Frequency')
axis tight;
%% 4.1.5 Plot data diff
figure(3);
Fs = 44100;
% Hs=spectrum.periodogram;	     % Use default values
[periodgm1,~] = periodogram(y_h1,[],[],Fs);
[periodgm2,~] = periodogram(y_h2,[],[],Fs);
[periodgm3,~] = periodogram(um_original(1:N,1),[],[],Fs);
[periodgm4,w] = periodogram(um_original(1:N,2),[],[],Fs);
periodgm1 = abs((periodgm3-periodgm1))./abs(periodgm3);
periodgm2 = abs((periodgm4-periodgm2))./abs(periodgm4);
abs(periodgm3);
clf(3);
hold all;
plot(w,periodgm1);
str = sprintf('Periodogram of normalized difference of magnitude of estimated and clean signal p_1=%d p_2=%d \\mu_1=%f \\mu_2=%f',p1,p2,mu1,mu2);
title(str)
ylabel('Amplitude')
plot(w,periodgm2);
legend('(P1-Ph1)/P1','(P2-Ph2)/P2');
axis tight;
ylabel('Amplitude')
xlabel('Frequency')
%% play the sample
a =audioplayer([y_h1 y_h2],FS);
play(a)