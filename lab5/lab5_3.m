clear;clc;
N_w = 5;
N=1000;
x = randn(N,1);
b = [1 2 3 2 1];
a=1;
y = filter(b,a,x);
n = 0.1.*randn(N,1);
z=n+y;
mu = 0.001;
w=zeros(N,N_w);
%inputs x,z,mu,N_w

%% function start
%[wp1 e w]
% function [w e] = lms_cust(x,z,mu,N_w)
N=length(x);
w=zeros(N,N_w);
y_h = zeros(N-N_w,1);
for i=N_w:N
y_h(i)=w(i,:)*x((i-N_w+1):i);
e(i) = z(i) - y_h(i);
w(i+1,:) = w(i,:) +mu*e(i)*x((i-N_w+1):i)'; 
% mu=min(0.006*exp(e(i)*1.1513)-0.001,0.2);
mu=min(max(0.055*e(i)-0.0733,0.01),0.2);
end
w = w(2:N+1,:);
% end

%% plots data
figure(1);
subplot(2,1,1)
plot(w);
str = sprintf('Evolution of coefficient estimates over time using LMS and final mu=%f',mu);
title(str);
legend('b1','b2','b3','b4','b5')
ylabel('Amplitude')
subplot(2,1,2)
plot(e.*e)
str = sprintf('Evolution of error^2 over time using LMS and final mu=%f',mu);
title(str);
ylabel('Amplitude')
xlabel('Time')
