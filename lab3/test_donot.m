clear all;
 
%Investigating the effects of improving teh periodogram estimate using averaging and filtering 
 
%Different Sample Size Definitions
L = 128;
M = 256;
N = 1024;
O = 128;
 
%Generate 4 samples from a random zero mean, unit std, Gaussian Processes 
x1 = randn(1, L);
x2 = randn(1, M);
x3 = randn(1, N);
x4 = randn(8, O); 
 
%Calculate Periodogogram of each sample of the Gaussian Proces 
[P1, k1] = pgm(x1);
[P2, k2] = pgm(x2);
[P3, k3] = pgm(x3);
 
%Pass periodogram through averaging filter
P1_filt = filtfilt([0.2, 0.2, 0.2, 0.2, 0.2], 1, P1);
P2_filt = filtfilt([0.2, 0.2, 0.2, 0.2, 0.2], 1, P2);
P3_filt = filtfilt([0.2, 0.2, 0.2, 0.2, 0.2], 1, P3);
 
 
%Split 1024 sample into 8 128 samples sub intervals
for j = 1:8,
[P31(j,:), k4] = pgm(x4(j,:));
end
 
P31_av = mean(P31); 
 
%Plots
figure(1)
subplot(3,1,1);
stem(k1, P1, '.'), title('Periodigram (PSD Estimate) of 128 samples from a Gaussian Process'), xlabel('Normalized Frequency'),ylabel('PSD Estimate');
subplot(3,1,2);
stem(k2, P2, '.'), title('Periodigram (PSD Estimate) of 256 samples from a Gaussian Process'), xlabel('Normalized Frequency'),ylabel('PSD Estimate');
subplot(3,1,3);
stem(k3, P3, '.'), title('Periodigram (PSD Estimate) of 512 samples from a Gaussian Process'), xlabel('Normalized Frequency'),ylabel('PSD Estimate');
 
figure(2)
subplot(3,1,1);
stem(k1, P1_filt, 'o'), title('Averaged Periodigram of 128 samples for Gaussian Noise'), xlabel('Normalized Frequency'),ylabel('Amplitude');
subplot(3,1,2);
stem(k2, P2_filt, 'o'), title('Averaged Periodigram of 256 samples for Gaussian Noise'), xlabel('Normalized Frequency'),ylabel('Amplitude');
subplot(3,1,3);
stem(k3, P3_filt, 'o'), title('Averaged Periodigram of 512 samples for Gaussian Noise'), xlabel('Normalized Frequency'),ylabel('Amplitude');
 
 
figure(3)
subplot(4,2,1);
stem(k4, P31(1,:), '.'), title('Periodigram (PSD Estimate) of samples 0-128'), xlabel('Normalized Frequency'),ylabel('PSD Estimate');
subplot(4,2,2);
stem(k4, P31(2,:), '.'), title('Periodigram (PSD Estimate) of samples 129-256'), xlabel('Normalized Frequency'),ylabel('PSD Estimate');
subplot(4,2,3);
stem(k4, P31(3,:), '.'), title('Periodigram (PSD Estimate) of samples 257-384'), xlabel('Normalized Frequency'),ylabel('PSD Estimate');
subplot(4,2,4);
stem(k4, P31(1,:), '.'), title('Periodigram (PSD Estimate) of samples 385-512'), xlabel('Normalized Frequency'),ylabel('PSD Estimate');
subplot(4,2,5);
stem(k4, P31(2,:), '.'), title('Periodigram (PSD Estimate) of samples 513-640'), xlabel('Normalized Frequency'),ylabel('PSD Estimate');
subplot(4,2,6);
stem(k4, P31(3,:), '.'), title('Periodigram (PSD Estimate) of samples 641-768'), xlabel('Normalized Frequency'),ylabel('PSD Estimate');
subplot(4,2,7);
stem(k4, P31(2,:), '.'), title('Periodigram (PSD Estimate) of samples 769-896'), xlabel('Normalized Frequency'),ylabel('PSD Estimate');
subplot(4,2,8);
stem(k4, P31(3,:), '.'), title('Periodigram (PSD Estimate) of samples 897-1024'), xlabel('Normalized Frequency'),ylabel('PSD Estimate');
 
 
figure(5)
str = sprintf('Averaged Periodigram of the 8 - 128 Gaussian noise sample sets \\sigma = %f mean=%f',std(P31_av), mean(P31_av))
stem(k4, P31_av, '.'), title(str), xlabel('Frequency'),ylabel('Amplitude');
 
 
figure(6);
stem(k3,P3);


