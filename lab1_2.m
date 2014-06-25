clc;
a = rp3(200,400);

subplot(2,1,1); plot(mean(a))
title('Mean')
subplot(2,1,2); plot(std(a))
title('Standard Deviation')
b=0;
c=0;
d=0;
for i = 1:1000;
a = rp3(200,400);
b(length(b)+1) = mean(mean(a));
c(length(c)+1) = mean(std(a));
end
figure(2)
gkdeb(c) %function written by Yi Cao (Cranfield University) to estimate pdf of input
%http://www.mathworks.co.uk/matlabcentral/fileexchange/19121-probability-density-function-pdf-estimator-v3-2/content/gkdeb.m
