clear,clc

syms x;
F = @(x) 1 / (1 + 25 * x^2);
y = [0:1:2000];

for i = 0:2000
    y(i + 1) = F(-1 + i * 2/2000);
end

figure
result = [0:1:2000];
delta_result = [2:1:7];

for n = 5:7
    count = 2^n;
    chebyshev = [0:1:count];

    for j = 0:1:count
        chebyshev(j + 1) = cos(j * pi / (count));
    end

    d_f = [1:1:count];
    g = [0:1:count];

    for i = 1:count + 1
        g(i) = F(chebyshev(i));
    end

    for k = 2:count + 1

        for i = count + 1:-1:k
            g(i) = (g(i) - g(i - 1)) / (chebyshev(i) - chebyshev(i - k + 1));
        end

    end

    i = 0;
    a = -1 + i * 2/2000;
    result(i + 1) = F(chebyshev(1));
    hh = [1:count];
    mm = [1:count];

    for j = 1:count
        tmp = 1;

        for k = 1:j
            tmp = tmp * (a - chebyshev(k));
        end

        result(i + 1) = result(i + 1) + tmp * g(j + 1);
        mm(j) = abs(tmp);
        hh(j) = abs(g(j + 1));
    end

    subplot(3, 2, 2 * (n - 4) - 1);
    semilogy([1:count], abs(hh));
    subplot(3, 2, 2 * (n - 4));
    semilogy([1:count], abs(mm));
end
