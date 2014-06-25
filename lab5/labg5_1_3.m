%% Setup 5.1.3
clc;
clear all;
close all;
N=100000;
N_w = 5;
x = randn(N,1);
%make r_xx matrix
r_xx_c = xcorr(x,'unbiased');
r_xx=zeros(N_w,N_w);
for i=1:N_w
    r_xx(:,i) = r_xx_c(N-i+1:N+N_w-i);
end
%unknown system
b = [1 2 3 2 1];
a=1;
y = filter(b,a,x);
%generate noise of 0.1 std.dev
for j=1:6
n = (0.1+1.98*(j-1)).*randn(N,1);
z=n+y;
p_y = sum(y.^2)/1000;
p_n = sum(n.^2)/1000;%get actual noise value
SNR = 10*log10(p_y/p_n);
fprintf('SNR is %f for iteration with sigma = %f\n',SNR,0.1+1.98*(j-1));

p_zx = xcorr(z,x,'unbiased');
p_zx = p_zx(N:N+N_w-1);
w_opt = r_xx\p_zx;
fprintf('w_opt is');
for k=1:length(w_opt)
    fprintf('\n%f',w_opt(k));
end
fprintf('\n______________\n');
end
[w e] = lms_cust(x,z,0.01,5);