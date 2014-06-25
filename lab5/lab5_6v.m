%% Adaptation from part 5.4
clc; clear;
file = 't.wav';
[x,fs] = wavread(file);
Fs=441;% in 100Hz set less than 441 to downsample
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
      x=x(16000:16000+add); %for t
end
x=resample(x,Fs,441);
[o1,o2, MDL, AIC] = aic_mdl(x,100);
p=mean(o1,o2);
p=3;
N = length(x);
a = zeros(N,p);
mu=2;
mu_ss = 0.01;
mu_se = 0.1;
e = zeros(N,1);
y_h = zeros(N,1);

for j=1:4
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
figure(1);
e = normal_e;
plot(e.*e);
figure(2);
clf(2);
hold;
plot(normal,'r');
plot(se_a,'g');
plot(sr_a,'b');
plot(ss_a,'k');
% legend('Normal','','signed - error','','signed -regressor','','sign-sign')
R_p = 10*log10(var(x)/var(e));
str = sprintf('\\bf{Letter:%s} \\rm{p=%d}\n',file(1),p);
str = [str sprintf('\\rm{Normal R_p = %f Signed-Error R_p = %f \n Signed-Regressor R_p = %f  Sign-Sign R_p = %f}',normal_rp,se_rp,sr_rp,ss_rp)];
str = [str sprintf('\nN=%d \\mu = %.3f \\mu_{se} = %.3f \\mu_{ss} = %.3f',N-1,mu,mu_se,mu_ss)]
title(str);
ylabel('Amplitude')
xlabel('Time')
[x,fs] = wavread(file);
x=resample(x,Fs,441);
x=filter(1,a(N,:),x);

sound = audioplayer(x,Fs*100);
play(sound);