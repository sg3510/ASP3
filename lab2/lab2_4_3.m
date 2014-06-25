clc;
clear;
%plots the stability triangle if called mutliple times
N = 1000;
a1=5.*rand(100,1)-2.5;
a2=3.*rand(100,1)-1.5;
w=randn(N,1);
% a1_2 = zeros(100,1)
% for j=1:100
%     a1_2(i) = a1(i)^i;
%     a2_2(i) = a2(i)^i;
% end

x = zeros(N,N);
x(:,1) = w(1);
x(:,2) = w(2)+a1(1)*x(:,1);
for j=1:100
    for i=3:N
        x(j,i) = w(i) + a1(j)*x(j,i-1) + a2(j)*x(j,i-2);
    end
end
a = zeros(100,1);
b = zeros(100,1);
for j=1:100
    %cehck for overshoot
    if (abs(x(j,N))>10)||(isnan(x(j,N)))
        disp(j)
        a(j) = a1(j);
        b(j) = a2(j);
        a1(j)=0;
        a2(j)=0;
    else
        str = sprintf('______________\nfor j=%d\na1:%f\na2:%f\nx_end:%f\na1+a2:%f\n',j,a1(j),a2(j),x(j,N),a1(j)+a2(j));
        disp(str);
    end
end
%clear coef list
a1(a1==0)=[];
a2(a2==0)=[];
a(a==0)=[];
b(b==0)=[];
plot(a1,a2,'r-');hold on
grid on
plot(a,b,'*'); 
xlabel('a1')
ylabel('a2')
str = sprintf('Coefficient pairs, red stable and blue unstable');
title(str)