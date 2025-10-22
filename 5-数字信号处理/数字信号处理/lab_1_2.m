fq=100;
syms t;
x2=exp(-100*t)*sin(2*pi*fq*t)*heaviside(t);

%画CFT幅频特性图
syms w;
X2=fourier(x2,t,w*2*pi);
X2_f=matlabFunction(-abs(X2));
W_m=fminbnd(X2_f,0,400);
subplot(2,3,1);
fplot(abs(X2)/abs(X2_f(W_m)),[0 400]);
title('x2的幅度谱');
xlabel('Hz');

%对连续信号进行采样
n=0:49;
fs1=1*fq; Ts1=1/fs1; n1=n*Ts1;
fs2=4*fq; Ts2=1/fs2; n2=n*Ts2;
fs3=6*fq; Ts3=1/fs3; n3=n*Ts3;
fs4=10*fq; Ts3=1/fs3; n4=n*Ts3;

xs1=eval(subs(x2,t,n1));
xs2=eval(subs(x2,t,n2));
xs3=eval(subs(x2,t,n3));
xs4=eval(subs(x2,t,n4));

k=0:49;
W=exp(-1i*pi/25);
X1=xs1*W.^(n'*k);
X2=xs2*W.^(n'*k);
X3=xs3*W.^(n'*k);
X4=xs4*W.^(n'*k);

subplot(2,3,2);
stem(k*fs1/50,abs(X1)/max(abs(X1)));
title('f采样后的幅度谱');
xlabel('Hz');
subplot(2,3,3);
stem(k*fs2/50,abs(X2)/max(abs(X2)));
title('4f采样后的幅度谱');
xlabel('Hz');
subplot(2,3,4);
stem(k*fs3/50,abs(X3)/max(abs(X3)));
title('6f采样后的幅度谱');
xlabel('Hz');
subplot(2,3,5);
stem(k*fs4/50,abs(X4)/max(abs(X4)));
title('10f采样后的幅度谱');
xlabel('Hz');




