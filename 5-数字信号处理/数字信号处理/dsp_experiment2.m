n = 0:3;   
x = [1,1,0,1];   
k=0:200;
w = (pi/200)*k
X=x*(exp(-j*pi/200)).^(n'*k);
subplot(3,1,1);
plot(w/pi,abs(X));
title('Magnitude Part');
xlabel('w/pi');ylabel('DTFT');

n=0:3;
x=[1,1,0,1];
k=n;
N=length(n);
y=x*exp(-j*2*pi/N).^(n'*k);%DFT
w=linspace(-2*pi,2*pi,500);
y1=x*exp(-j*n'*w);%DTFT
subplot(3,1,2);stem(k,abs(y),'.');ylabel('DFT');
subplot(3,1,3);plot(w/pi,abs(y1));xlabel('X pi');ylabel('DTFT');







