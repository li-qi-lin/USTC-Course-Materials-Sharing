% 指定设计参数
rp = 1; % 通带起伏（dB）
rs = 40; % 止带衰减（dB）
T = 10; % 矩形信号的周期（秒）
fs = 100; % 采样频率（Hz）

% 指定不同的r值
r_values = [1, 5, 10, 15, 20, 40];

% 遍历不同的r值进行滤波器设计和信号生成
for i = 1:length(r_values)
    r = r_values(i);
    wp = 2*pi*r/fs; % 通带截止频率（rad/s）
    ws = wp + 0.1*pi; % 止带截止频率（rad/s）

    % 使用buttord函数计算滤波器的阶数和截止频率
    [n, wn] = buttord(wp, ws, rp, rs, 's');
    
    % 降低滤波器的阶数为2
    n = 2;

    % 使用butter函数设计IIR低通滤波器
    [b, a] = butter(n, wn, 's');

    % 计算所需的采样点数
    N = T * fs;

    % 生成矩形信号序列x(n)
    x = [ones(1, N/2), zeros(1, N/2)]; % 矩形信号序列

    % 使用filtfilt函数对x(n)进行滤波得到y(n)
    y = filtfilt(b, a, x);

    % 计算x(n)和y(n)的幅频特性
    Nfft = 1024; % FFT点数
    X = fft(x, Nfft); % x(n)的频谱
    Y = fft(y, Nfft); % y(n)的频谱
    f = (0:Nfft-1)*(fs/Nfft); % 频率轴

    % 绘制幅频特性曲线
    figure;
    hold on;
    plot(f, abs(X)/max(abs(X)), 'b', 'LineWidth', 1.5); % x(n)的归一化幅度谱
    plot(f, abs(Y)/max(abs(Y)), 'r', 'LineWidth', 1.5); % y(n)的归一化幅度谱
    hold off;
    xlabel('频率 (Hz)');
    ylabel('归一化幅度');
    legend('x(n)', 'y(n)');
    title(['r = ', num2str(r)]);
end