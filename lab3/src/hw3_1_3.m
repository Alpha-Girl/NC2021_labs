clear,clc,close all

syms x;
F = @(x)sin(x);
maxrept = 50;
a = cos(1.2);

for i = 0:15
    h = 10^(-i);

    for k = -15:-5
        epslion = 10^(k);
        A(1) = N(h);
        A(2) = N(h / 2);
        tmp = 2 * A(2) - A(1);

        if i == 0
            B(1) = abs(N(h) - a);
            B(2) = abs(tmp - a);
        end

        while abs(tmp - A(1)) >= epslion && length(A) <= maxrept

            A(1) = tmp;
            A(length(A) + 1) = N(h / (2^(length(A) - 1)));

            for j = 1:length(A) - 2
                A(length(A) - j) = A(length(A) - j + 1) + (A(length(A) - j + 1) - A(length(A) - j)) / (2^j - 1);
            end

            tmp = A(2) + (A(2) - A(1)) / (2^(length(A) - 1) - 1);

            if i == 0
                B(length(A)) = abs(tmp - a);
            end

        end

        if length(A) <= maxrept && abs(tmp) > epslion
            X = sprintf('h:10^%d tmp:%.15f epslion:10^%d n:%d delta:%.15f', -i, tmp, k, length(A), abs(tmp - a));
            disp(X)
            break;
        end

        if i == 0
            B = [];
        end

        A = [];
    end

end

semilogy(1:length(B), B);

function result = N(h)
    syms y;
    F = @(y)sin(y);
    result = (F(1.2 + h) - F(1.2)) / h;
end
