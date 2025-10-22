fh=100;
syms t;
x1=sin(2*pi*fh*t)/t;

%画CFT幅频特性图
syms w;
X1=fourier(x1,t,w*2*pi);
X1_n=X1/pi;
subplot(2,3,1);
fplot(abs(X1_n),[0 120]);
title('x1的幅度谱');
xlabel('Hz');

%对连续信号进行采样
n=-25.5:1:24.5;
fs1=0.3*fh; Ts1=1/fs1; n1=n*Ts1;
fs2=0.6*fh; Ts2=1/fs2; n2=n*Ts2;
fs3=1.2*fh; Ts3=1/fs3; n3=n*Ts3;
fs4=1.8*fh; Ts4=1/fs4; n4=n*Ts4;
fs5=2.4*fh; Ts5=1/fs5; n5=n*Ts5;
xs1=eval(subs(x1,t,n1));
xs2=eval(subs(x1,t,n2));
xs3=eval(subs(x1,t,n3));
xs4=eval(subs(x1,t,n4));
xs5=eval(subs(x1,t,n5));

%采样完毕，开始进行离散时间傅里叶变换
k=0:49;
%k2=0:59;
%k3=0:119;
%k4=0:179;
%k5=0:239;
W=exp(-1i*pi/25);
%W2=exp(-1i*pi/30);
%W3=exp(-1i*pi/60);
%W4=exp(-1i*pi/90);
%W5=exp(-1i*pi/120);
X1=xs1*W.^(n'*k);
X2=xs2*W.^(n'*k);
X3=xs3*W.^(n'*k);
X4=xs4*W.^(n'*k);
X5=xs5*W.^(n'*k);

%绘图
subplot(2,3,2);
stem(k*fs1/50,abs(X1)/max(abs(X1)));
title('0.3f采样后的幅度谱');
xlabel('Hz');
subplot(2,3,3);
stem(k*fs2/50,abs(X2)/max(abs(X2)));
title('0.6f采样后的幅度谱');
xlabel('Hz');
subplot(2,3,4);
stem(k*fs3/50,abs(X3)/max(abs(X3)));
title('1.2f采样后的幅度谱');
xlabel('Hz');
subplot(2,3,5);
stem(k*fs4/50,abs(X4)/max(abs(X4)));
title('1.8f采样后的幅度谱');
xlabel('Hz');
subplot(2,3,6);
stem(k*fs5/50,abs(X5)/max(abs(X5)));
title('2.4f采样后的幅度谱');
xlabel('Hz');


