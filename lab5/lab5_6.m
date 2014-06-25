%% Adaptation from part 5.4
clc; clear;
p=2;
N = 1000;
n = randn(N,1);
a = [1, 0.9, 0.2];
x= filter(1,a,n);
a = zeros(N,p);
mu=0.01;
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
            a(i+1,:) = a(i,:) + mu*sign(e(i))*x(i-1:-1:i-p)'; % signed - error
        case 3
            a(i+1,:) = a(i,:) + mu*e(i)*sign(x(i-1:-1:i-p))'; % signed  -regressor
        case 4
            a(i+1,:) = a(i,:) + mu*sign(e(i))*sign(x(i-1:-1:i-p))'; % signed  -regressora(i+1,:) = a(i,:) + mu*sign(e(i))*sign(x(i-1:-1:i-p))'; % signed  -regressor
    end
end
    switch j
        case 1
            normal = a;
            normal_e = e;
            normal_rp = 10*log10(var(x)/var(e));
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
plot(e);
figure(2);
clf(2);
hold;
plot(normal,'r');
plot(se_a,'g');
plot(sr_a,'b');
plot(ss_a,'k');
legend('Normal','','signed - error','','signed -regressor','','sign-sign')
R_p = 10*log10(var(x)/var(e));
str = sprintf('Normal R_p = %f Signed-Error R_p = %f \n Signed-Regressor R_p = %f  Sign-Sign R_p = %f &\\mu = %f',normal_rp,se_rp,sr_rp,ss_rp,mu);
title(str);
ylabel('Amplitude')
xlabel('Time')
axis([0 N -1 .3])