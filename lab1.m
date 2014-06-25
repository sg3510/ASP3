clc;
a=0;
x = randn(1000,1);
[a,b] = hist(x);
a = a./1000;
%b=-.9:0.2:.9;
sprintf('mean:%.6f',mean(x))
sprintf('std:%.6f',std(x))
bar(b,a)
