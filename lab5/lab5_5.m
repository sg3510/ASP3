%% Adaptation from part 5.4
clc; clear;
file = 't.wav';
[x,fs] = wavread(file);
Fs=160;% in 100Hz set less than 441 to downsample
add = ceil(1000*441/Fs);
switch file(1)
   case 'a'
      x=x(39000:39000+add); %for a
   case 'e'
      x=x(23000:23000+add); %for e
   case 's'
      x=x(20000:20000+add); %for s
   case 't'
      x=x(37000:37000+add); %for t
   case 'x'
      x=x(16000:16000+add); %for x
end
x=resample(x,Fs,441);
[o1,o2, MDL, AIC] = aic_mdl(x,100);
p=mean(o1,o2);
p=8;
N = length(x);
a = zeros(N,p);
mu=1;
mu_ss = 0.01;
mu_se = 0.1;
e = zeros(N,1);
y_h = zeros(N,1);

for j=1:1
for i = p+1:N
    y_h(i) = a(i,:)*x(i-1:-1:i-p);
    e(i) = x(i) - y_h(i);
    switch j
        case 1
            a(i+1,:) = a(i,:) + mu*e(i)*x(i-1:-1:i-p)'; % normal
        case 2
            a(i+1,:) = a(i,:) + mu_se*sign(e(i))*x(i-1:-1:i-p)'; % signed - error
        case 3
            a(i+1,:) = a(i,:) + mu*e(i)*sign(x(i-1:-1:i-p))'; % signed  -regressor
        case 4
            a(i+1,:) = a(i,:) + mu_ss*sign(e(i))*sign(x(i-1:-1:i-p))'; % signed  -regressora(i+1,:) = a(i,:) + mu*sign(e(i))*sign(x(i-1:-1:i-p))'; % signed  -regressor
    end
end
    switch j
        case 1
            normal = a;
            normal_e = e;
            normal_rp = 10*log10(var(x)/var(e));
            ss_a = 0 ;
            ss_e = 0;
            ss_rp = 0;
        case 2
            se_a = a;
            se_e = e;
            se_rp = 10*log10(var(x)/var(e));
        case 3
            sr_a = a;
            sr_e = e;
            sr_rp = 10*log10(var(x)/var(e));
        case 4
            ss_a = a;
            ss_e = e;
            ss_rp = 10*log10(var(x)/var(e));
    end
end
%% thing
figure(1);
subplot(2,1,1);
plot(e.^2);
axis tight;
str = sprintf('{\\bfLetter: %s} at %2.1fkHz\n Error^{2} over time with p=%d {\\itMDL suggested p=%d AIC suggested p=%d}',file(1),Fs/10,p,o1,o2);
title(str);
ylabel('Amplitude')
xlabel('Time')
subplot(2,1,2);
plot(a);
R_p = 10*log10(var(x)/var(e));
fprintf('%f',R_p);
str = sprintf('Prediction quality (R_p) is %5.5f N=%d \\mu = %.3f\nCoefficients',normal_rp,N-1,mu);
title(str);
ylabel('Amplitude')
xlabel('Time')
axis tight;
[x,fs] = wavread(file);
x=resample(x,Fs,441);
x=filter(1,a(N,:),x);

sound = audioplayer(x,Fs*100);
play(sound);

[h,w] = freqz(1,a(N,:));
figure(2)
plot((1:length(h))*Fs*100/length(h),20*log10(abs(h)))
str = sprintf('Frequency plot of a coefficients (freqz) \nLetter: %s',file(1));
title(str);
ylabel('Amplitude')
xlabel('Time')
% legend('16kHz p=8 \mu=4','16kHz p=4 \mu=4','44.1kHz p=8 \mu=4','44.1kHz p=14 \mu=4')
grid on;