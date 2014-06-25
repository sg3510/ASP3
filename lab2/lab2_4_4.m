clc;
clear;
N = 288;
load sunspot.dat
year=sunspot(1:N,1);
x =sunspot(1:N,2);
% for i=1:10
% str = sprintf('ar_%d = aryule(x,%d);',i,i);
% disp(str)
% end
%get coefs
ar_1 = aryule(x,1);
ar_2 = aryule(x,2);
ar_3 = aryule(x,3);
ar_4 = aryule(x,4);
ar_5 = aryule(x,5);
ar_6 = aryule(x,6);
ar_7 = aryule(x,7);
ar_8 = aryule(x,8);
ar_9 = aryule(x,9);
ar_10 = aryule(x,10);
% for i=1:10
% str = sprintf('plot(ar_%d);',i);
% disp(str)
% end
%plot them
figure(1)
hold on
plot(ar_1,'y');
plot(ar_2,'m');
plot(ar_3,'c');
plot(ar_4,'r');
plot(ar_5,'g');
plot(ar_6,'b');
plot(ar_7,'m');
plot(ar_8,'w');
plot(ar_9,'k');
plot(ar_10);
hold off
xlabel('Order of AR')
ylabel('Ceofs')
str = sprintf('Coefficients of AR');
title(str)
figure(2)
% parcorr(x,[],2)
pyulear(x,2)
