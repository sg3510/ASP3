clc;
clear;
close all;
N = 288;

load sunspot.dat
year=sunspot(1:N,1);
sdata = sunspot(1:N,2);
sdata = sdata - mean(sdata);
ar_1 = aryule(sdata,1);
ar_2 = aryule(sdata,2);
ar_3 = aryule(sdata,3);
ar_4 = aryule(sdata,4);
ar_5 = aryule(sdata,5);
ar_6 = aryule(sdata,6);
ar_7 = aryule(sdata,7);
ar_8 = aryule(sdata,8);
ar_9 = aryule(sdata,9);
ar_10 = aryule(sdata,10);
w = randn(N,1);
x = zeros(N,10);
% ar_1(1) = -1;
% ar_2(1) = -1;
% ar_3(1) = -1;
% ar_4(1) = -1;
% ar_5(1) = -1;
% ar_6(1) = -1;
% ar_7(1) = -1;
% ar_8(1) = -1;
% ar_9(1) = -1;
% ar_10(1) = -1;
x(:,1) = filter(-1*ar_1(1:end),1,sdata);
x(:,2) = filter(-1*ar_2(1:end),1,sdata);
x(:,3) = filter(-1*ar_3(1:end),1,sdata);
x(:,4) = filter(-1*ar_4(1:end),1,sdata);
x(:,5) = filter(-1*ar_5(1:end),1,sdata);
x(:,6) = filter(-1*ar_6(1:end),1,sdata);
x(:,7) = filter(-1*ar_7(1:end),1,sdata);
x(:,8) = filter(-1*ar_8(1:end),1,sdata);
x(:,9) = filter(-1*ar_9(1:end),1,sdata);
x(:,10) = filter(-1*ar_10(1:end),1,sdata);
b = zeros(N,10);
b(:,1) = filter(ar_1,1,w);
b(:,2) = filter(ar_2,1,w);
b(:,3) = filter(ar_3,1,w);
b(:,4) = filter(ar_4,1,w);
b(:,5) = filter(ar_5,1,w);
b(:,6) = filter(ar_6,1,w);
b(:,7) = filter(ar_7,1,w);
b(:,8) = filter(ar_8,1,w);
b(:,9) = filter(ar_9,1,w);
b(:,10) = filter(ar_10,1,w);
% for i=1:10
% str = sprintf('x(:,%d) = filter(1,ar_%d,w(:,%d));',i,i,i);
% disp(str)
% end
E=zeros(N,10);
o = ones(1,10);
E(1,:) = (x(1,:)-o*sdata(1)).^2;
%E(1,:) = (x(1,:)-b(1,:)).^2;
for i=2:N
    E(i,:) = (x(i,:)-o*sdata(i)).^2 + E(i-1,:);
    %E(i,:) = (x(i,:)-b(i,:)).^2 + E(i-1,:);
end
MDL = log(E(N,(1:10))) + (1:10)*log(N)/N;
AIC = log(E(N,(1:10))) + (1:10)*2/N;
plot(AIC,'r'); hold on
plot(MDL); 
plot(log(E(N,:)),'-g');hold off
legend('AIC','MDL','Cumulative Squared Error')