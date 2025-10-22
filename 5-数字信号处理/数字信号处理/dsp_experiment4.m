n=0:1023;
x1=31.6*exp(j*3*pi*n/7) + 0.005*exp(j*4*pi*n/5);

N=length(n);
X1_rect=fft(x1.*rectwin(N)');
X1_rect_dB=20*log10(abs(X1_rect));

X1_hamm=fft(x1.*hamming(N)');
X1_hamm_dB=20*log10(abs(X1_hamm));

k = 0:N-1;
figure;
subplot(2,1,1);
plot(k, X1_rect_dB);
xlabel('k');ylabel('X1_rect_dB');title('Rectangular Window');grid on;

subplot(2,1,2);
plot(k, X1_hamm_dB);
xlabel('k');ylabel('X1_hamm_dB');title('hamming Window');grid on;



N1=1024; N2=2048;
n1=0:N1-1; n2=0:N2-1;
x2_n1=31.6*exp(j*3*pi*n1/7)+10*exp(j*(1/7+1/1024)*3*pi*n1);
x2_n2=31.6*exp(j*3*pi*n2/7)+10*exp(j*(1/7+1/1024)*3*pi*n2);

X2_N1=fft(x2_n1.*blackman(N1)');
X2_N1_dB=20*log10(abs(X2_N1));

X2_N2=fft(x2_n2.*blackman(N2)');
X2_N2_dB=20*log10(abs(X2_N2));

k1=0:N1-1;
k2=0:N2-1;
figure;
subplot(2, 1, 1);
plot(k1, X2_N1_dB);
xlabel('k');ylabel('X2_N1_dB');title('N=1024');grid on;

subplot(2, 1, 2);
plot(k2, X2_N2_dB);
xlabel('k');ylabel('X2_N2_dB');title('N=2048');grid on;





