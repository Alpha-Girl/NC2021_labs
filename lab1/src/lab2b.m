clear,clc
syms x;
maxrept = 1000;
f(x) = x^3 - 3 * x^2 + 2;
g(x) = diff(f, x);
epsilon = 10^(-15);

fprintf("set x_0=-3,find out the answer in [-3,0]\n");
x_0 = -3;
x_1 = x_0 - (f(x_0) / g(x_0));
fprintf("iter        x                    order\n");

for i = 1:maxrept
    x_2 = x_1 - (f(x_1) / g(x_1));

    if i >= 2
        order_0 = order_1;
        order_1 = log(abs(x_2 - x_1) / abs(x_1 - x_0));
        Alpha = order_1 / order_0;
        fprintf("%d        %.16f     %.16f\n", i, x_1, Alpha);
    else
        order_1 = log(abs(x_2 - x_1) / abs(x_1 - x_0));
        fprintf("%d        %.16f     \n", i, x_1);
    end

    if abs(x_1 - x_0) < epsilon
        break
    end

    x_0 = x_1;
    x_1 = x_2;
end

fprintf("The answer is %.16f\n", x_1);
fprintf("set x_0=1.5,find out the answer in [0,2]\n");
x_0 = 1.5;
x_1 = x_0 - (f(x_0) / g(x_0));
fprintf("iter        x                    order\n");

for i = 1:maxrept
    x_2 = x_1 - (f(x_1) / g(x_1));

    if i >= 2
        order_0 = order_1;
        order_1 = log(abs(x_2 - x_1) / abs(x_1 - x_0));
        Alpha = order_1 / order_0;
        fprintf("%d        %.16f     %.16f\n", i, x_1, Alpha);
    else
        order_1 = log(abs(x_2 - x_1) / abs(x_1 - x_0));
        fprintf("%d        %.16f     \n", i, x_1);
    end

    if abs(x_1 - x_0) < epsilon
        break
    end

    x_0 = x_1;
    x_1 = x_2;
end

fprintf("The answer is %.16f\n", x_1);
fprintf("set x_0=3,find out the answer in [2,4]\n");
x_0 = 3;
x_1 = x_0 - (f(x_0) / g(x_0));
fprintf("iter        x                    order\n");

for i = 1:maxrept
    x_2 = x_1 - (f(x_1) / g(x_1));

    if i >= 2
        order_0 = order_1;
        order_1 = log(abs(x_2 - x_1) / abs(x_1 - x_0));
        Alpha = order_1 / order_0;
        fprintf("%d        %.16f     %.16f\n", i, x_1, Alpha);
    else
        order_1 = log(abs(x_2 - x_1) / abs(x_1 - x_0));
        fprintf("%d        %.16f     \n", i, x_1);
    end

    if abs(x_1 - x_0) < epsilon
        break
    end

    x_0 = x_1;
    x_1 = x_2;
end

fprintf("The answer is %.16f\n", x_1);
