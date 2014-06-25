clc;
close all;
clear all;
% PART 2.4.5 & 2.5.6
load sunspot.dat;
year = sunspot(:,1);
data = sunspot(:,2);
N = length(data);
years = 50;
%Process the MDL and AIC for 100 orders
for i = 1:100
    [coefficients,E] = aryule(data, i);
    ord = length(coefficients);  
    y(:,i) = filter(-1*coefficients(2:end),1,data(:));%cut off first value and negate the rest due to the way the equation works
    MDL(i,1) = log(sum(E)) + (i*log(N))/N;%Calculate MDL
    AIC(i,1) = log(sum(E)) +(2*i)/N;%Calculate AIC
    Er(i) = log(sum(E));
end
 %Generate coefficients for AR processes
coeffs_order2 = -1*aryule(data, 2);
coeffs_order6 = -1*aryule(data, 6);
coeffs_order9 = -1*aryule(data, 9);
ar2(1) = data(1);
ar2(2) = data(2);
 
%Initialise all
for i = 1:20
 ar2(i) = data(i);
 ar6(i) = data(i);
 ar9(i) = data(i);    
end
 
%AR2 prediction
for i = 1:years-2,
    ar2(2+i) = coeffs_order2(2)*ar2(1+i) + coeffs_order2(3)*ar2(i);
end
%AR6 prediction
for i = 1:years-6,
   ar6(6+i) = coeffs_order6(2)*ar6(5+i) + coeffs_order6(3)*ar6(4+i) + coeffs_order6(4)*ar6(3+i) + coeffs_order6(5)*ar6(2+i) + coeffs_order6(6)*ar6(1+i) + coeffs_order6(7)*ar6(i);
end
 
%AR9 future
for i = 1:years-9,
    ar9(9+i) = 0;
    for j = 1:9
        ar9(9+i) = ar9(9+i) + coeffs_order9(1+j)*ar9(9+i-j);
    end
end
    
%Plot all
figure(1)
plot(MDL), title('MDL and AIC'), xlabel('Order'), ylabel('Magnitude');
hold on;
plot(AIC,'r');
plot(Er,'g');
legend('MDL','AIC','Cumulative Error^2');
 
figure(2)
str = sprintf('AR predictions & real data over %d years (for predictions)', years);
plot(ar2), title(str), xlabel('Year'), ylabel('Amplitude');
hold on;
plot(ar6, 'g');
plot(ar9, 'k');
 
plot(data(1:years),'r');
legend('AR2 Prediction','AR6 Prediction','AR9 Prediction','Real Data')
hold off;