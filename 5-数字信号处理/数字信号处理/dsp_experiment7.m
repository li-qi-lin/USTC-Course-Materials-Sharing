f = 150e6; % 中心频率
B = 100e6; % 通带宽度
delta_f = 10e6; % 过渡带宽度
fs = 500e6; % 采样频率

f_pass = [f - B/2, f + B/2]; % 通带频率范围
f_stop = [0, f - B/2 - delta_f/2, f + B/2 + delta_f/2, fs/2]; % 阻带频率范围

% 绘制不同阶数下的滤波器幅频特性曲线
N_values = [16, 32, 64, 128]; % 不同的阶数值

figure;
hold on;
for i = 1:length(N_values)
    N = N_values(i);
    filter_coeffs = fir1(N, f_pass/(fs/2), 'BANDPASS', boxcar(N+1)); % 设计滤波器
    [h, w] = freqz(filter_coeffs, 1, 1024, fs); % 计算滤波器的频率响应
    plot(w, abs(h)/max(abs(h))); % 绘制归一化幅度谱
end
hold off;

xlabel('频率 (Hz)');
ylabel('归一化幅度');
legend('N = 16', 'N = 32', 'N = 64', 'N = 128');

