syms t 
y1=exp(-100*t)*sin(pi*200*t)*heaviside(t);
y2=fourier(y1); 
ny2=y2/max(abs(y2),1e-10);
subplot(6,1,1); hold on;
fplot(y1,[-0.1,0.1]) 
title('原信号');
subplot(6,1,2); hold on;
fplot(abs(y2),[-0.001,0.001])   
title('幅频');

N=1000;
fs1=100;fs2=400; fs3=600; fs4=1000; 			
T1=1/fs1; T2=1/fs2; T3=1/fs3; T4=1/fs4;
k1=0:fs1*N; k2=0:fs2*N; k3=0:fs3*N; k4=0:fs4*N;
n = -100: 1 :100 ;
w1 = pi*k1/N; w2 = pi*k2/N; w3 = pi*k3/N; w4 = pi*k4/N;
x1=exp(-100*n*T1).*sin(pi*200*n*T1);  x2=exp(-100*n*T2).*sin(pi*200*n*T2);  
x3=exp(-100*n*T3).*sin(pi*200*n*T3);  x4=exp(-100*n*T4).*sin(pi*200*n*T4);  

X1=x1*exp(-j*n'*w1);
subplot(6,1,3);
plot(w1/pi,abs(X1)/abs(max(X1)));
title('100Hz采样信号序列的幅度谱');

X2=x2*exp(-j*n'*w2); 	
subplot(6,1,4);
plot(w2/pi,abs(X2)/abs(max(X2)));
title('400Hz采样信号序列的幅度谱');

X3=x3*exp(-j*n'*w3);  				
subplot(6,1,5);
plot(w3/pi,abs(X3)/abs(max(X3)));
title('600Hz采样信号序列的幅度谱');

X4=x4*exp(-j*n'*w4);   					
subplot(6,1,6);
plot(w4/pi,abs(X4)/abs(max(X4)));
title('1000Hz采样信号序列的幅度谱');
