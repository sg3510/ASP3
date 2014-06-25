% clear all;
% clc;
% load sunspot.dat;
% data = sunspot(:,2);
% p=100;
function [o1,o2, MDL, AIC] = aic_mdl(data,p)
N = length(data);

for i = 1:p
    [coefficients,E] = aryule(data, i);
    y(:,i) = filter(-1*coefficients(2:end),1,data(:));
    MDL(i,1) = log(sum(E)) + (i*log(N))/N;
    AIC(i,1) = log(sum(E)) +(2*i)/N;
end
[~,o1] = min(MDL);
[~,o2] = min(AIC);
end
% figure(1)
% %subplot(2,1,1)
% plot(MDL), title('Minimum Description Length (MDL) for different Model Orders'), xlabel('Model Order'), ylabel('MDL & AIC');
% %subplot(2,1,2)
% hold;
% plot(AIC,'r');%, title('Akaike Information Criterion (AIC) for different Model Orders'), xlabel('Model Order'), ylabel('AIC');
% legend('MDL','AIC')
% hold;