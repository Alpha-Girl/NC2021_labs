clc, clear, close all

syms x;
syms y;
F = @(x, y)x * exp(-4 * x) - 4 * y;
G = @(x)1/2 * x^2 * exp(-4 * x);
Y_0 = 0;

for j = 2:10000
    n = j;
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

    delta(j - 1) = abs(G(2) - result(n + 1));
    L(j - 1) = h;
end

figure;
subplot(1, 2, 1)
loglog(L, delta);
logl = log10(L);
logd = log10(delta);
t = polyfit(logl, logd, 1);
subplot(1, 2, 2);
plot(logl, logd, '*', logl, polyval(t, logl));
