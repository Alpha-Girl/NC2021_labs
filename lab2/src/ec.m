clc
syms x;
left = -1;
right = 1;
n1 = 2000;
m0 = 0;
mn = 0;
step1 = (right - left)/n1;
y(x) = 1 / (1 + 25 * x.^2);
x1 = left:step1:right;

arr_n = [2.^2, 2.^3, 2.^4, 2.^5, 2.^6, 2.^7];
[~, ll] = size(arr_n);
maxn = zeros(1, ll);
for j = 4:4
    n = 2.^j;
    step = (right - left)/n;
    qb(x) = cos(x * pi / n) * (right - left) + left;
    Nx(x) = newton(y, qb, n);
    fy = zeros(1, n1 + 1);
    dev = zeros(1, n1 + 1);
    for i = 1 : n1
        fy(i) = Nx(x1(i));
        dev(i) = abs(fy(i) - y(x1(i)));
    end
    maxn(j - 2 + 1) = max(dev(i));
end
figure
semilogy(x1, dev);
%semilogy(arr_n, maxn)


function [Nx] = newton(y, qb, n)
    sym y;  
    sym t;
    sym Nx;
    sym qb;
    syms x;
    g = zeros(1, n);
    rng(22);
    rand_arr = randperm(n + 1);
    for i = 1 : n
        g(i) = y(qb(rand_arr(i + 1) - 1));
    end
    for i = 1 : n
        for j = n : -1 : i
            if j == 1
                g(j) = (g(j) - y(qb(rand_arr(1) - 1)))/(qb(rand_arr(j + 1) - 1) - qb(rand_arr(j - i + 1) - 1));
            else
                g(j) = (g(j) - g(j - 1))/(qb(rand_arr(j + 1) - 1) - qb(rand_arr(j - i + 1) - 1));
            end
        end
    end
    t = 1;
    Nx = y(qb(0));
    for i = 1 : n
        t = t * (x - qb(rand_arr(i) - 1));
        Nx = Nx + t * g(i);
    end
end