%% Setup
clc;
clear all;
close all;
N=1000;
N_w = 20;
x = randn(N,1);
plot(x);
%unknown system
b = [1 2 3 2 1];
a=1;
y = filter(b,a,x);
%normalize system y to have unity variance
%y = y./sqrt((sum(b.*b)));
%generate noise of 0.1 std.dev
n = 0.1.*randn(N,1);
z=n+y;
p_y = sum(y.^2)/1000;
p_n = sum(n.^2)/1000;%get actual noise value
SNR = 10*log10(p_y/p_n);
fprintf('SNR is %f\n',SNR);
%% Part 5.1.1
r_xx_c = xcorr(x,'unbiased');
r_xx=zeros(N_w,N_w);
for i=1:N_w
    r_xx(:,i) = r_xx_c(N-i+1:N+N_w-i);
end
p_zx = xcorr(z,x,'unbiased');
p_zx = p_zx(N:N+N_w-1);
%% Part 5.1.2
w_opt = r_xx\p_zx;