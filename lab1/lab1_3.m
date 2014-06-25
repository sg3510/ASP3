clc;
N=100;
%v=randn(1,N);
v=rp3(1,N);
u=rp3(1,N*10);
w=rp3(1,N*100);
figure(1)
gkdeb(v);
[a,b]=hist(v,50);
figure(2)
a=a/trapz(b,a);%more accurate than dividing by N
%as dividing by N is true only if the bin size is small 
%relative to the variance of the data
subplot(4,1,1)
axis tight
bar(b,a);
ylabel('Probability')
title('Estimated PDF N=100')
%%%%%%%%%%%
subplot(4,1,2)
[a,b]=hist(u,50);
a=a/trapz(b,a);
bar(b,a);
axis tight
ylabel('Probability')
title('Estimated PDF N=1000')
%%%%%%%%%%%
subplot(4,1,3)
[a,b]=hist(w,50);
a=a/trapz(b,a);
axis tight
bar(b,a);
axis tight
ylabel('Probability')
title('Estimated PDF N=10000')
%%%%%%%%%%%
subplot(4,1,4)
x=0.01:0.01:1;
y = ones(1,100).*1/2;
plot(x,y)
axis tight
xlabel('X')
ylabel('Probability')
title('Theoretical PDF')