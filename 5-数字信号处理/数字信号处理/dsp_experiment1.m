syms t 
y1=sinc(200*t)*200*pi;
y2=fourier(y1); 
ny2=y2/max(abs(y2),1e-6);
subplot(7,1,1); hold on;
fplot(y1,[-1,1]) 
title('原信号');
subplot(7,1,2); hold on;
fplot(abs(ny2),[0,120])  
title('幅频');

N=1000;
fs1=30;	fs2=60; fs3=120; fs4=180; fs5=240;		
T1=1/fs1; T2=1/fs2; T3=1/fs3; T4=1/fs4; T5=1/fs5;									
k1=0:fs1*N; k2=0:fs2*N; k3=0:fs3*N; k4=0:fs4*N;k5=0:fs5*N;
n = -100: 1 :100 ;
w1 = pi*k1/N; w2 = pi*k2/N; w3 = pi*k3/N; w4 = pi*k4/N;w5 = pi*k5/N;
x1=sinc(200*n*T1);x2=sinc(200*n*T2);  x3=sinc(200*n*T3);
x4=sinc(200*n*T4);  x5=sinc(200*n*T5);

X1=x1*exp(-j*n'*w1); 					
subplot(7,1,3);
plot(w1/pi,abs(X1)/abs(max(X1)));
title('30Hz采样信号序列的幅度谱');

X2=x2*exp(-j*n'*w2); 					
subplot(7,1,4);
plot(w2/pi,abs(X2)/abs(max(X2)));
title('60Hz采样信号序列的幅度谱');

X3=x3*exp(-j*n'*w3); 
subplot(7,1,5);
plot(w3/pi,abs(X3)/abs(max(X3)));
title('120Hz采样信号序列的幅度谱');

X4=x4*exp(-j*n'*w4); 				
subplot(7,1,6);
plot(w4/pi,abs(X4)/abs(max(X4)));
title('180Hz采样信号序列的幅度谱');

X5=x5*exp(-j*n'*w5);  		
subplot(7,1,7);
plot(w5/pi,abs(X5)/abs(max(X5)));
title('240Hz采样信号序列的幅度谱');





