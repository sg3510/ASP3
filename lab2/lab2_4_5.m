clc;
clear;
close all;
N = 288;

load sunspot.dat
year=sunspot(1:N,1);
sdata = sunspot(1:N,2);
sdata = sdata - mean(sdata);
w = randn(N,1);
x = zeros(N,10);
for i = 1:10
    ar = aryule(sdata, i);    % yw for Yule-Walker method
    x(:,i) = filter(-1*ar(1:end),1,sdata);
end
E=zeros(N,10);
o = ones(1,10);
E(1,:) = (x(1,:)-o*sdata(1)).^2;
for i=2:N
    E(i,:) = (x(i,:)-o*sdata(i)).^2 + E(i-1,:);
end
MDL = log(E(N,(1:10))) + (1:10)*log(N)/N;
AIC = log(E(N,(1:10))) + (1:10)*2/N;
plot(AIC,'r'); hold on
plot(MDL); 
plot(log(E(N,:)),'-g');hold off
legend('AIC','MDL','Cumulative Squared Error')