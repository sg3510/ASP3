clc; clear;
%initialise all variables
p=2;
N = 100000;
n = randn(N,1);
a = [1, 0.9, 0.2];
x= filter(1,a,n);
a = zeros(N,p);
% can also be made a function
%function [y_e, e, a] = LMS_AR(x, mu, p)
mu=0.0001;
e = zeros(N,1);
%perform AR recognition/estimation
y_h = zeros(N,1);
for i = p+1:N
    y_h(i) = a(i,:)*x(i-1:-1:i-p); %a1(i)*x(i-1)+a2(i)*x(i-2);
    e(i) = x(i) - y_h(i);
    a(i+1,:) = a(i,:) + mu*e(i)*x(i-1:-1:i-p)';
end
%end %use for fucntion, comment the rest out
%% plot everything
figure(1);
plot(e.*e);
figure(2);
clear figure(2);
plot(a);
str = sprintf('final a1:%f and final a2:%f estimation \n\\mu = %f',a(N,1),a(N,2),mu);
title(str);
ylabel('Amplitude')
xlabel('Time')
axis([0 N -1 .3])