clc,clear
syms x;
left = -1;
right = 1;
n = 2.^4;
n1 = 2000;
m0 = 0;
mn = 0;
step = (right - left)/n;
step1 = (right - left)/n1;
y(x) = sin(4 * x.^2) + (sin(4 * x)).^2;
x2 = left:step1:right;
res = myFunc(y, left, right, n, m0, mn);
fy = zeros(1, n1 + 1);
dev = zeros(1, n1 + 1);
for i = 1 : n1
    seq = floor((x2(i) - left)/step) + 1;
    fy(i) = res(seq, 1) * x2(i).^3 + res(seq, 2) * x2(i).^2 + res(seq, 3) * x2(i) + res(seq, 4);
    dev(i) = abs(fy(i) - y(x2(i)));
end
figure
semilogy(x2, dev)

function [res] = myFunc(y, left, right, n, m0, mn)
    sym y;
    step = (right - left)/n;
    lambda = 1/2;
    mu = 1 - lambda;
    d = zeros(n + 1, 1);
    A = zeros(n + 1, n + 1);
    res = zeros(n, 4);
    para = left;
    for i = 2 : n
        para = para + step;
        d(i, 1) = 6 * (y(para + step) + y(para - step) - 2 * y(para)) / (2 * step.^2);
        A(i, i - 1) = mu;
        A(i, i) = 2;
        A(i, i + 1) = lambda;
    end
    d(1, 1) = 6 / step * ((y(left + step) - y(left))/step - m0);
    d(n + 1, 1) = 6 / step * (mn - (y(right) - y(right - step))/step);
    A(1, 1) =  2;
    A(1, 2) = 1;
    A(n + 1, n) = 1;
    A(n + 1, n + 1) = 2;
    m = A\d;
    d
    m
    para = left;
    for i = 1 : n
        para1 = para + step;
        A1 = [
            para.^3 para.^2 para 1;
            para1.^3 para1.^2 para1 1;
            6 * para 2 0 0;
            6 * para1 2 0 0;
            ];
        Y = [
            y(para);
            y(para1);
            m(i, 1);
            m(i + 1, 1);
            ];
        X = A1\Y;
        for j = 1 : 4
            res(i, j) = X(j, 1);
        end
        para = para1;
    end
end