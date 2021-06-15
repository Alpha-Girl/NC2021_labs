clear,clc,close all

syms x;
F = @(x)sin(x);
epslion = 10^(-15);

for i = 0:15
    h = 10^(-i);
    A(1) = N
    result = [0:15];
    h_l = result;
    tmp = cos(1.2);
    f = F(1.2);

    for i = 0:15
        h = 10^(-i);
        h_l(i + 1) = h;
        result(i + 1) = abs((F(1.2 + i) - f) / h - tmp);
    end

    loglog(h_l, result);

    function result = N[h]
        syms y;
        F = @(y)sin(y);
        result = (F(1.2 + h) - F(1.2)) / h;
    end
