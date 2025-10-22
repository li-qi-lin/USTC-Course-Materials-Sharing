f1=24;
f2=60;

syms t;
x1=exp(1i*2*pi*f1*t)+exp(1i*2*pi*f2*t);

% 进行CFT以及幅度归一化
syms w;
X1=fourier(x1,t,w);
X1_n=X1/2/pi

%判断周期函数并进行FS展开
T0=1/12;
W0=24*pi;
m=0:50;
a_m=int(x1*exp(-1i*2*pi*m*t/T0),t,0,T0)/T0;
subplot(3,3,1);
stem(m,abs(a_m));
title('FS展开的幅频特性')

%定义矩形窗截断的函数
x_R1=x1*(heaviside(t)-heaviside(t-2*T0));
x_R2=x1*(heaviside(t)-heaviside(t-1.6*T0));
X_R1=fourier(x_R1,t,w);
X_R2=fourier(x_R2,t,w);
subplot(3,3,2);
fplot(abs(X_R1));
title('R1=2T0截短后的幅频特性曲线');
subplot(3,3,3)
fplot(abs(X_R2));
title('R2=1.6T0截短后的幅频特性曲线');

%对x1进行离散化
n=0:1:99;
fs1=600; Ts1=1/fs1; n1=n*Ts1;
fs2=600; Ts2=1/fs2; n2=n*Ts2;
xs1=eval(subs(x_R1,t,n1));
xs2=eval(subs(x_R2,t,n2));

%取样后作DTFT
k=0:99;
W=exp(-1i*pi/50);
X1_DTFT=xs1*W.^(n'*k);
X2_DTFT=xs2*W.^(n'*k);
subplot(3,3,4);
stem(k*fs1/50,abs(X1_DTFT)/max(abs(X1_DTFT)));
title('xR1采样后的幅度谱');
xlabel('Hz');
subplot(3,3,5)
stem(k*fs2/50,abs(X2_DTFT)/max(abs(X2_DTFT)));
title('xR2采样后的幅度谱');
xlabel('Hz');

%取样后作DFT
%N1=100
%N2=80
W1=exp(-1i*pi/50);
n1=0:99;
W2=exp(-1i*pi/40);
n2=0:79;
X1_DFT=xs1*W1.^(n1'*n1);
xs2_sub=xs2(1:80);
X2_DFT=xs2_sub*W2.^(n2'*n2);
subplot(3,3,6);
stem(n1,abs(X1_DFT));
title('DFT幅频特性1');
subplot(3,3,7);
stem(n2,abs(X2_DFT));
title('DFT幅频特性2');

%进行矩阵之间的拼接
xs1_c=[xs1,zeros(1,200)];
xs2_c=[xs2(1:80),zeros(1,160)];
n1_c=0:299;
W1_c=exp(-1i*pi/150);
n2_c=0:239;
W2_c=exp(-1i*pi/120);
X1_c_DFT=xs1_c*W1_c.^(n1_c'*n1_c);
X2_c_DFT=xs2_c*W2_c.^(n2_c'*n2_c);
subplot(3,3,8);
stem(n1_c,abs(X1_c_DFT));
title('拼接后DFT幅频特性1');
subplot(3,3,9);
stem(n2_c,abs(X2_c_DFT));
title('拼接后DFT幅频特性2');










