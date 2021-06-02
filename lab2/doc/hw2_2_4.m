clear,clc

syms x;
F = @(x) 1 / (1 + 25 * x^2);
y = [0:1:2000];

for i = 0:2000
    y(i + 1) = F(-1 + i * 2/2000);
end

result = [0:1:2000];
delta_result = [2:1:7];
rng(22);
r = randperm(4 + 1);
figure;

for n = 2:4
    count = n;
    chebyshev = [0:1:count];

    for j = 1:1:count + 1
        chebyshev(j) = cos((r(j) - 1) * pi / (count));
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

    for i = 0:2000
        a = -1 + i * 2/2000;
        result(i + 1) = F(chebyshev(1));

        for j = 1:count
            tmp = 1;

            for k = 1:j
                tmp = tmp * (a - chebyshev(k));
            end

            result(i + 1) = result(i + 1) + tmp * g(j + 1);
        end

    end

    tmp = [0:1:2000];

    for i = 0:2000
        tmp(i + 1) = abs(result(i + 1) - y(i + 1));
    end

    subplot(2, 3, 2 * (n - 1) - 1);
    plot([-1:2/2000:1], result);
end

for n = 2:4
    count = n;
    chebyshev = [0:1:count];

    for j = 1:1:count + 1
        chebyshev(j) = cos(j - 1) * pi / (count);
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

    for i = 0:2000
        a = -1 + i * 2/2000;
        result(i + 1) = F(chebyshev(1));

        for j = 1:count
            tmp = 1;

            for k = 1:j
                tmp = tmp * (a - chebyshev(k));
            end

            result(i + 1) = result(i + 1) + tmp * g(j + 1);
        end

    end

    tmp = [0:1:2000];

    for i = 0:2000
        tmp(i + 1) = abs(result(i + 1) - y(i + 1));
    end

    subplot(2, 3, 2 * (n - 1));
    plot([-1:2/2000:1], result);
end
