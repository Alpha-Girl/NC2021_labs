clc
syms x;
left = -1;
right = 1;
n1 = 2000;
step1 = (right - left)/n1;
y(x) = sin(4 * x.^2) + (sin(4 * x)).^2;
x1 = left:step1:right;

arr_n = [2.^4, 2.^5, 2.^6, 2.^7, 2.^8, 2.^9, 2.^10];
[~, ll] = size(arr_n);
maxn = zeros(1, ll);
figure
for j = 4 : 10
    n = 2.^j;
    step = (right - left)/n;
    x = left:step:right;
    res = myFunc(y, left, right, n);
    fy = zeros(1, n1 + 1);
    dev = zeros(1, n1 + 1);
    for i = 1 : n1
        seq = floor((x1(i) - left)/step) + 1;
        fy(i) = res(seq, 1) * x1(i).^3 + res(seq, 2) * x1(i).^2 + res(seq, 3) * x1(i) + res(seq, 4);
        dev(i) = abs(fy(i) - y(x1(i)));
    end
    maxn(j - 4 + 1) = max(dev(i));
end
loglog(arr_n, maxn)


function [res] = myFunc(y, left, right, n)
    sym y;
    step = (right - left)/n;
    lambda = 1/2;
    mu = 1 - lambda;
    d = zeros(n, 1);
    A = zeros(n, n);
    res = zeros(n, 4);
    para = left;
    for i = 2 : n
        para = para + step;
        d(i, 1) = 6 * (y(para + step) + y(para - step) - 2 * y(para)) / (2 * step.^2);
    end
    d(1, 1) = 6 / step * (y(left + step) - y(left) + y(right) - y(right - step)) / step;
    A(1, 1) =  4;
    A(1, 2) = 1;
    A(1, 3) = 1;
    for i = 2 : n - 1
        A(i, i - 1) = mu;
        A(i, i) = 2;
        A(i, i + 1) = lambda;
    end
    A(n, 1) = lambda;
    A(n, n - 1) = mu;
    A(n, n) = 2;
    m = A\d;
    m(n + 1, 1) = m(1, 1);
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