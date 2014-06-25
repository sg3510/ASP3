clc;
%%%%%%%%%
v=rp1(1,1000);
plot(v)
[a,b] = hist(v,100);
a = a./trapz(b,a);
%bar(b,a);
xlabel('Time')
ylabel('Probability')
title('Collected Data for N=1000')
%%%%%%%%%
% subplot(2,1,2)
% v=rp1(1,1000);
% [a,b] = hist(v,100);
% a = a./trapz(b,a);
% bar(b,a);
% xlabel('X')
% ylabel('Probability')
% title('Collected Data for N=1000')