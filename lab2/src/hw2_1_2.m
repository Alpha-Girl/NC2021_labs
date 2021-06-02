clear,clc
syms x;
F = @(x) sin(4 * (x^2)) + (sin(4 * x))^2;
n = 2^10;
A = eye(n + 1);
A = 2 * A;
A(1, 2) = 1;
A(n + 1, n) = 1;
h = (1 - (-1)) / n;
lambda = 1/2;
mu = 1 - lambda;

for i = 2:n
    A(i, i - 1) = mu;
    A(i, i + 1) = lambda;
end

y = [0:1:n];
xx = [0:1:n];

for i = 1:n + 1
    xx(i) = -1 + (i - 1) * h;
    y(i) = F(xx(i));
end

d = [0:1:n];

for i = 2:n
    d(i) = 3 * (y(i + 1) - 2 * y(i) + y(i - 1)) / (h^2);
end

d(1) = 6 / h * ((y(2) - y(1)) / h - 0);
d(n + 1) = 6 / h * (0 - (y(n + 1) - y(n)) / h);
d = d';
M = A \ d;
k = 1;
xk_1 = xx(2);
xk = xx(1);
h_new = 2/2000;
t = -1;
C = y(1) / h - h * M(1) / 6;
D = y(2) / h - h * M(2) / 6;
error_delta = [0:1:n];

for i = 0:2000
    t = -1 + i * h_new;

    if (t >= xk && t <= xk_1) || t > 1
        s = (xk_1 - t)^3 / (6 * h) * M(k) + (t - xk)^3 / (6 * h) * M(k + 1) + C * (xk_1 - t) + D * (t - xk);
        error_delta(i + 1) = abs(s - F(t));

    else
        k = k + 1;
        xk_1 = xx(k + 1);
        xk = xx(k);
        C = y(k) / h - h * M(k) / 6;
        D = y(k + 1) / h - h * M(k + 1) / 6;
        s = (xk_1 - t)^3 / (6 * h) * M(k) + (t - xk)^3 / (6 * h) * M(k + 1) + C * (xk_1 - t) + D * (t - xk);
        error_delta(i + 1) = abs(s - F(t));
    end

end

semilogy([-1:h_new:1], error_delta)
