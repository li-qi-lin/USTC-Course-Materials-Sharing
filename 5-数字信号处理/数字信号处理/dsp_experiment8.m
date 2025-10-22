% (1) 设计IIR低通滤波器
wp = 0.8*pi; % 通带截止频率
rp = 1; % 通带起伏（dB）
ws = wp + 0.1*pi; % 过渡带截止频率
rs = 40; % 止带衰减（dB）

[n, wn] = buttord(wp, ws, rp, rs, 's');
[b1, a1] = butter(n, wn, 's');

% 绘制幅频特性曲线和相频特性曲线
figure;
freqz(b1, a1);

% % 测量滤波器的群时延
% [gd, w] = grpdelay(b, a);
% avg_gd = mean(gd);
% fprintf('IIR滤波器的平均群时延：%.2f 个采样点\n', avg_gd);

% 计算群时延和对应的频率
figure;
[gd, w] = grpdelay(b1, a1); 
plot(w, gd);
xlabel('频率');
ylabel('群时延');
title('滤波器的群时延');

% (2) 设计FIR低通滤波器
wc = 0.8*pi; % 通带截止频率
ws = wc + 0.1*pi; % 过渡带截止频率
rs = 40; % 止带衰减（dB）

% 计算滤波器阶数
N = ceil((rs-7.95)/(14.36*(ws-wc)/(2*pi)) + 1);

% 使用fir1函数设计FIR低通滤波器
b2 = fir1(N, wc/pi);

% 绘制幅频特性曲线
figure;
freqz(b2, 1);

% % 测量滤波器的群时延
% [gd, w] = grpdelay(b, 1);
% avg_gd = mean(gd);
% fprintf('FIR滤波器的平均群时延：%.2f 个采样点\n', avg_gd);

% 计算群时延和对应的频率
figure;
[gd, w] = grpdelay(b2, 1); 
plot(w, gd);
xlabel('频率');
ylabel('群时延');
title('滤波器的群时延');

% (3) 生成输入信号并通过滤波器观察群延迟
N = 80; % 序列长度
n = 0:N-1;
w1 = 0.1*pi; % 输入信号1的频率
w2 = 0.7*pi; % 输入信号2的频率

x1 = sin(w1*n);
x2 = sin(w2*n);

% 通过IIR滤波器
y1_iir = filter(b1, a1, x1);
y2_iir = filter(b1, a1, x2);
delay_iir = round(avg_gd); % 由于群时延是浮点数，需要四舍五入取整

% 绘制时域波形图
figure;
subplot(4,1,1);
stem(n, x1,'.');
title('x1');
subplot(4,1,2);
stem(n, y1_iir,'.');
title('x1的IIR滤波器输出');
subplot(4,1,3);
stem(n, x2,'.');
title('x2');
subplot(4,1,4);
stem(n, y2_iir,'.');
title('x2的IIR滤波器输出');

% 通过FIR滤波器
y1_fir = filter(b2, 1, x1);
y2_fir = filter(b2, 1, x2);
delay_fir = round(avg_gd); % 由于群时延是浮点数，需要四舍五入取整

% 绘制时域波形图
figure;
subplot(4,1,1);
stem(n, x1,'.');
title('x1');
subplot(4,1,2);
stem(n, y1_fir,'.');
title('x1的FIR滤波器输出');
subplot(4,1,3);
stem(n, x2,'.');
title('x2');
subplot(4,1,4);
stem(n, y2_fir,'.');
title('x2的FIR滤波器输出');

% (4) 生成由两个输入信号相加而成的信号并通过滤波器观察输出
x = x1 + x2;

% 通过IIR滤波器
y_iir = filter(b1, a1, x);
y_fir = filter(b2, 1, x);

% 绘制时域波形图
figure;
subplot(3,1,1);
stem(n, x,'.');
title('输入信号');
subplot(3,1,2);
stem(n, y_iir,'.');
title('IIR滤波器输出');
subplot(3,1,3);
stem(n,y_fir,'.');
title('FIR滤波器输出');

