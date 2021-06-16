clc, clear, close all
syms x;
F = @(x) exp(cos(x));
maxrept = 50;
r = 7.95492652101284527451;

for i = 2:maxrept
    h = 2 * pi / i;
    S = F(-pi) / 2 + F(pi) / 2;

    for j = 1:i - 1
        S = S + F(-pi + j * h);
    end

    S = S * h;
    T(i - 1) = abs(S - r);
end

semilogy([2:maxrept], T);
