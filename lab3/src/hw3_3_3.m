clc, clear, close all

syms x;
syms y;
F = @(x, y)x * exp(-4 * x) - 4 * y;
Y_0 = 0;
n = 10^5;
t = 0;
h = 2 / n;
result(1) = Y_0;
k1 = F(t, result(1));
k2 = F(t + h / 2, result(1) + k1 * h / 2);
result(2) = result(1) + k2 * h;
k1 = F(t + h, result(2));
k2 = F(t + h + h / 2, result(2) + k1 * h / 2);
result(3) = result(2) + k2 * h;

for i = 3:n
    tmp = result(i - 1) + h / 3 * (F(t, result(i - 2)) - 2 * F(t + h, result(i - 1)) + 7 * F(t + 2 * h, result(i)));
    result(i + 1) = result(i - 1) + h / 3 * (F(t + h, result(i - 1)) + 4 * F(t + 2 * h, result(i)) + F(t + 3 * h, tmp));
    t = t + h;
end

plot([0:2 / n:2], result);
