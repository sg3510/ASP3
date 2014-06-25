function [P, k] = pgm(data)
%returns PSD estimate in P with the normalized frequencies in k
%input is a set of input valuesn which form the signal in time domain
N = length(data);
k = (0:1/N:(N-1)/N);
P=zeros(N,1);
for n = 1:N 
    e = exp((-1i*2*pi*(n-1)).*(0:1:N-1)'./N)';
    P(n) = (abs(sum((data.*e)))).^2./N;
end
end

% function x=pgm(data)
% N=length(data);
% a = zeros(N,1);
% f = 0:1:(N-1);
% % for f = 1:1:(N-1);
% %     a(1)=data(1);
% %    for n=0:N-1;
% %        a(f+1)=a(f)+data(1+n)*exp(-1i*2*pi*f*n/N^2);
% %    end
% % end
% a=data.*exp(-1i*2*pi*(f.*(0:1:N-1)/N));
% a = abs(a.^2);
% x=a/N;
% end