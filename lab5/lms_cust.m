clear;clc;
N_w = 5;
N=1000;
x = randn(N,1);
b = [1 2 3 2 1];
a=1;
y = filter(b,a,x);
n = 0.1.*randn(N,1);
z=n+y;
mu = 0.01;
w=zeros(N,N_w);
% inputs x,z,mu,N_w

%% function start
%[wp1 e w]
% function [w e] = lms_cust(x,z,mu,N_w)
%lms function
%takes in the noise, the filtered system and the learning constant in addition to the order of the filter
%returns the estimated coefficients over time as well as the errror
N=length(x);
w=zeros(N,N_w);
y_h = zeros(N-N_w,1);
for i=N_w:N
y_h(i)=w(i,:)*x((i-N_w+1):i);
e(i) = z(i) - y_h(i);
w(i+1,:) = w(i,:) +mu*e(i)*x((i-N_w+1):i)'; 
end
w = w(2:N+1,:);
% end

%% plots data
figure(1);
subplot(2,1,1)
plot(w);
str = sprintf('Evolution of coefficient estimates over time using LMS and mu=%f',mu);
title(str);
legend('b1','b2','b3','b4','b5')
ylabel('Amplitude')
subplot(2,1,2)
plot(e.*e)
str = sprintf('Evolution of error sqaured over time using LMS and mu=%f',mu);
title(str);
ylabel('Amplitude')
xlabel('Time')