close all; 
clear all;
rp = 1; % 通带起伏（dB）
rs = 40; % 止带衰减（dB）
T = 10; % 矩形信号的周期
N = 100;
r_values = [1, 5, 10, 15, 20, 40];
% 生成矩形信号序列x(n)
x1 = [ones(1, N/2), zeros(1, N/2)]; % 矩形信号序列1个周期
x = repmat(x1, 1, T); %10个周期

figure;
for i = 1:length(r_values)
    r = r_values(i);
    wp = 2*r/N; % 通带截止频率（pi*rad/s）
    ws = wp + 0.1; % 止带截止频率（pi*rad/s）

    % 使用buttord函数计算滤波器的阶数和截止频率
    [n, wn] = buttord(wp, ws, rp, rs);

    % 使用butter函数设计IIR低通滤波器
    [b, a] = butter(n, wn);

    % 使用filtfilt函数对x(n)进行滤波得到y(n)
    y = filtfilt(b, a, x);

    % 计算x(n)和y(n)的幅频特性
    Nfft = 1024; % FFT点数
    X = fft(x, Nfft); % x(n)的频谱
    Y = fft(y, Nfft); % y(n)的频谱
    f = (0:Nfft-1)*(N/Nfft); % 频率轴

    subplot(6,2,2*i-1);
    hold on;
    plot(f, abs(X)/max(abs(X)), 'b'); % x(n)幅度谱
    plot(f, abs(Y)/max(abs(Y)), 'r'); % y(n)幅度谱
    hold off;
    xlabel('频率 (Hz)');
    ylabel('归一化幅度');
    legend('x(n)', 'y(n)');
    title(['频域，r = ', num2str(r)]);

    x_to_plot = x(100 : 500);
    y_to_plot = y(100 : 500);

    subplot(6,2,2*i);
    hold on;
    %stem(x_to_plot,'b')
    %stem(y_to_plot,'r')
    plot(x_to_plot,'b') % stem看不清的话可换成plot
    plot(y_to_plot,'r')
    hold off;
    xlabel('n');
    ylabel('幅度');
    legend('x(n)', 'y(n)');
    title(['时域，r = ', num2str(r)]);
end

% 切比雪夫
% 参数设置
Rp = 1;      % 通带最大衰减（dB）
Rs = 15;     % 阻带最小衰减（dB）
omega_p = 0.2*pi;   % 通带截止频率 rad/s
omega_s = 0.3*pi;   % 阻带截止频率 rad/s

% 计算滤波器阶数
[Nc, omega_c] = cheb1ord(omega_p, omega_s, Rp, Rs, 's');

% 设计模拟切比雪夫I型高通滤波器
[num, den] = cheby1(Nc, Rp, omega_c, 'high', 's');

% 双线性变换
[num_d, den_d] = bilinear(num, den, 1); %设采样频率为1Hz

% 时域波形
yhp = filter(num_d, den_d, x);

% 绘制时域波形
figure;
subplot(4,2,1);
plot(x,'b');
title('输入x(n)');

subplot(4,2,2);
% stem(yhp, 'r');
plot(yhp, 'r'); % stem看不清的话可换成plot
title('y_{hp}(n)');

%叠加
for i = 1:length(r_values)
    r = r_values(i);

    wp = 2*r/N; % 通带截止频率（pi*rad/s）
    ws = wp + 0.1; % 止带截止频率（pi*rad/s）
    [n, wn] = buttord(wp, ws, rp, rs);
    [b, a] = butter(n, wn);
    y = filtfilt(b, a, x);

    y2 = y + yhp;
    subplot(4,2,2+i);
    hold on;
%     stem(yhp,'b')
%     stem(y2,'r')
    plot(yhp,'b') % stem看不清的话可换成plot
    plot(y2,'r')
    hold off;
    xlabel('n');
    ylabel('幅度');
    legend('yhp(n)', 'y(n)+yhp(n)');
    title(['时域叠加，r = ', num2str(r)]);
end

