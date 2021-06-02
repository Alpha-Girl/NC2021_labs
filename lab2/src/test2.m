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

for n = 2:7
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

    for j = 1:count
        tmp = 1;

        for k = 1:j
            tmp = tmp * (a - chebyshev(k));
        end

        result(i + 1) = result(i + 1) + tmp * g(j + 1);
        hh(j) = abs(tmp * g(j + 1));
    end

    [x, k] = max(result);
    X = sprintf('%f,%d,%d', x, k, n);
    disp(X)
    subplot(6, 2, n - 1);
    semilogy([1:count], abs(hh));
end



for n = 2:7
    count = 2^n;
    chebyshev = [0:1:count];
    rng(22);
    r = randperm(count + 1);

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

    i = 0;
    a = -1 + i * 2/2000;
    result(i + 1) = F(chebyshev(1));
    mm = [1:count];

    for j = 1:count
        tmp = 1;

        for k = 1:j
            tmp = tmp * (a - chebyshev(k));
        end

        result(i + 1) = result(i + 1) + tmp * g(j + 1);
        mm(j) = abs(tmp * g(j + 1));
    end

    [x, k] = max(result);
    X = sprintf('%f,%d,%d', x, k, n);
    disp(X)
    subplot(6, 2, 6+n - 1);
    semilogy([1:count], abs(mm));
    mm
end

