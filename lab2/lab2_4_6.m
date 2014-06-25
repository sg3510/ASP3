clc;
clear;
close all;
load sunspot.dat
year=sunspot(:,1);
% x =sunspot(:,2);

data = sunspot(:,2);      % the seq you gave
coeffs = aryule(data, 2);
for i=1:length(coeffs)-1
coeffs(i) = -1*coeffs(i+1);
end
v=[1 2 5 10];
for j=1:4
x(j,1) = sunspot(1,2);
x(j,2) = sunspot(2,2);
for i = 1:v(j)
% a = sum((coeffs(1:end-1) .* x(end:-1:end-1)));
a = x(j,end)*coeffs(1) + x(j,end-1)*coeffs(2);
x(j,end+1) = a;
end
subplot(4,1,j);
plot(x(j,:));
xlabel('AR Y-W Prediction')
ylabel('Amplitude')
str = sprintf('n=%d',v(j));
title(str)
end
% x = x - mean(x);
% ar_2 = aryule(x,2);
% ar_2 = ar_2;
% ar_6 = aryule(x,6);
% for i=1:50
% x(end+1) = ar_2(2)*x(end-1)+ar_2(3)*x(end-2);
% end

% m = ar(x, p, 'yw');    % yw for Yule-Walker method
% pred = predict(m, x, 1);
% 
% coeffs = m.a;
% nextValue = pred(end);
% 
% subplot(121), plot(x)
% subplot(122), plot( pred )