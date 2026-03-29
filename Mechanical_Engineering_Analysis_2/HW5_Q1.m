clc;
clear;
close all;

%% Q1(a)Load clean audio
load r2112.mat

rush = rush(:);             
N = length(rush);
dt = 1/FS;

sound(rush,FS)

%% FFT of clean signal
Y = fft(rush,N);

% Frequency axis
f = (1/(dt*N))*(0:N-1);
L = 1:floor(N/2);         

figure
plot(f(L),abs(Y(L)),'LineWidth',2)
xlabel('Frequency (Hz)')
ylabel('|FFT|')
title('FFT of Audio Signal')
grid on

%% Q1(b) Power Spectral Density
PSD = (Y.*conj(Y))/N;

figure
plot(f(L),PSD(L),'LineWidth',2)
xlabel('Frequency (Hz)')
ylabel('Power')
title('Power Spectral Density')
grid on

%% Spectrogram of clean signal
figure
spectrogram(rush,1024,512,1024,FS,'yaxis')
title('Spectrogram of Clean Signal')
colormap jet

%% Q1(c) Load noisy audio
load r2112noisy.mat

rushnoisy = rushnoisy(:);
n = length(rushnoisy);
dt = 1/FS;

sound(rushnoisy,FS)

%% FFT of noisy signal
Y_noisy = fft(rushnoisy,n);

%% Frequency-domain filtering
filteredcoefs = Y_noisy;

% Remove high frequency coefficients
filteredcoefs(floor(n/4):n) = 0;

%% Reconstruct clean signal
cleansignal = real(ifft(filteredcoefs));

% Renormalize power
cleansignal = 2*cleansignal;

pause(length(rushnoisy)/FS + 1)
sound(cleansignal,FS)

%% PSD comparison
PSD_noisy = (Y_noisy.*conj(Y_noisy))/n;

Y_clean = fft(cleansignal,n);
PSD_clean = (Y_clean.*conj(Y_clean))/n;

f = (1/(dt*n))*(0:n-1);
L = 1:floor(n/2);

figure
plot(f(L),PSD_noisy(L),'r','LineWidth',2)
hold on
plot(f(L),PSD_clean(L),'b','LineWidth',2)
legend('Noisy','Filtered')
xlabel('Frequency (Hz)')
ylabel('Power Spectral Density')
title('PSD Before and After Filtering')
grid on

%% Spectrograms
figure
subplot(2,1,1)
spectrogram(rushnoisy,1024,512,1024,FS,'yaxis')
title('Spectrogram of Noisy Signal')

subplot(2,1,2)
spectrogram(cleansignal,1024,512,1024,FS,'yaxis')
title('Spectrogram of Filtered Signal')

colormap jet