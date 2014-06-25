clc;
close all;
clear;
N = 250;
load sunspot.dat
year=sunspot(1:N,1);
x =sunspot(:,2);
x=x-mean(x);
x = x(1:N);
[a,b] = xcorr(x, 'unbiased');
stem(b,a)
xlabel('Year lag')
ylabel('Sunspot Numbers')
str = sprintf('Sunspot Data for N=%d',N);
title(str)