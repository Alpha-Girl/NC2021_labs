clear,clc;
syms x;
maxrept = 1000;
f(x) = x^3 - 3 * x^2 + 2; %Equation to be solved
g(x) = diff(f, x); %df/dx
epsilon = 10^(-15);

fprintf("set x_l=-3,find out x_l in [-3,0]\n");
x_l = Newton(-3, f, g, epsilon, maxrept);
fprintf("The answer of x_l is %.16f\n", x_l);
fprintf("set x_m=1.5,find out the answer in [0,2]\n");
x_m = Newton(1.5, f, g, epsilon, maxrept);
fprintf("The answer of x_m is %.16f\n", x_m);
fprintf("set x_r=3,find out the answer in [2,4]\n");
x_r = Newton(3, f, g, epsilon, maxrept);
fprintf("The answer of x_m is %.16f\n", x_r);

function x = Newton(x_0, f, g, epsilon, maxrept)
    x_1 = x_0 - (f(x_0) / g(x_0));
    fprintf("iter        x                    order\n");

    for i = 1:maxrept
        x_2 = x_1 - (f(x_1) / g(x_1));

        if i >= 2
            % Calculate the order of convergence
            order_0 = order_1;
            order_1 = log(abs(x_2 - x_1) / ...
                abs(x_1 - x_0));
            Alpha = order_1 / order_0;
            fprintf("%d        %.16f     %.16f\n", ...
                i, x_1, Alpha);
        else
            % First iteration
            order_1 = log(abs(x_2 - x_1) / ...
                abs(x_1 - x_0));
            fprintf("%d        %.16f     \n", i, x_1);
        end

        % convergence or not
        if abs(x_1 - x_0) < epsilon
            break
        end

        % update
        x_0 = x_1;
        x_1 = x_2;
    end

    x = x_1;

end
