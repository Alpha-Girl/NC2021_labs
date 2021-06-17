clear,clc

syms x;
F = @(x) sin(x);
result = [0:15];
h_l = result;
tmp = cos(1.2);
f = F(1.2);

for i = 0:15
    h = 10^(-i);
    h_l(i + 1) = h;
    result(i + 1) = abs((F(1.2 + h) - f) / h - tmp);
end

loglog(h_l, result);
