n=0:3;
x=[1,1,0,1];
k=n;
N=length(n);
dft=x*exp(-j*2*pi/N).^(n'*k);%DFT
w=linspace(-2*pi,2*pi,500);
dtft=x*exp(-j*n'*w);%DTFT
subplot(3,1,1);stem(k,abs(dft),'.');ylabel('DFT');
subplot(3,1,2);plot(w/pi,abs(dtft));xlabel('X pi');ylabel('DTFT');

X=0;
for k=0:N-1
X = X + (1/N)*(1-exp(-j*w*N))*dft(k+1)./(1-exp(j*2*pi/N*k)*exp(-j*w));
end
subplot(3,1,3);plot(w/pi,abs(X));xlabel('X pi');ylabel('重建的X');






