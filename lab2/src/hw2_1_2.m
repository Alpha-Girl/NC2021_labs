clear,clc
syms x;
F = @(x) sin(4 * x^2) + sin(4 * x)^2;
f = @(x) 8 * x * cos(4 * x^2) + 2 * sin(4 * x) * 4 * cos(4 * x);
n = 2^4;
A = eye(n + 1);
A = 2 * A;
A(1, 2) = 1;
A(n + 1, n) = 1;
h = (1 - (-1)) / n;
lambda = h / (h + h);
mu = 1 - lambda;

for i = 2:n
    A(i, i - 1) = mu;
    A(i, i + 1) = lambda;
end

y = [0:1:n];

for i = 1:n + 1
    y(i) = F(-1 + (i - 1) / 2 * h);
end

d = [0:1:n];

for i = 2:n
    d(i) = 6 / (h + h) * ((y(i + 1) - y(i)) / h - (y(i) - y(i - 1)) / h);
end

d(1) = 6 / h * ((y(2) - y(1)) / h - f(-1));
d(n + 1) = 6 / h * (f(1) - (y(n + 1) - y(n)) / h);
d = d';
M = A \ d;
k = 1;
xk_1 = -1 + h;
xk = -1;
h_new = 2/2000;
t = -1;
C = y(1) / h - h * M(1) / 6;
D = y(2) / h - h * M(2) / 6;
error_delta = [0:1:n];

for i = 1:2000
    t = t + h_new;

    if t > xk_1 && t<1
        k = k + 1;
        xk_1 = xk_1 + h;
        xk = xk + h;
        C = y(k) / h - h * M(k) / 6;
        D = y(k + 1) / h - h * M(k + 1) / 6;
    end

    s = (xk_1 - t)^3 / (6 * h) * M(k) + (t - xk)^3 / (6 * h) * M(k + 1) + C * (xk_1 - t) + D * (t - xk);
    error_delta(i) = abs((s - F(t)) / F(t));
end

semilogy(error_delta)
