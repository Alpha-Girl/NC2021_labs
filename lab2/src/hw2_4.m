clc, clear
x = [2.1, 2.5, 2.8, 3.2];
y = [0.6087, 0.6849, 0.7368, 0.8111];
a_1 = 0;
b_1 = 0;
x_y = x .* y;
c_11 = sum(x .* x);
c_12 = -sum(x .* x_y);
c_21 = -c_12;
c_22 = -sum(x_y .* x_y);
B_1 = sum(x .* y);
B_2 = sum(x_y .* y);
C = [c_11, c_12; c_21, c_22];
B = [B_1; B_2];
tmp = C \ B;
a_1 = tmp(1);
b_1 = tmp(2);
a = 1 / a_1;
b = b_1 / a_1;
y_bar = [Phi(x(1), a, b), Phi(x(2), a, b), Phi(x(3), a, b), Phi(x(4), a, b)];
delta_y = y - y_bar;
X = sprintf('The 2-norm of the error of the fitting function compared to the given data point is %.15f', norm(delta_y, 2));
disp(X)

function value = Phi(x, a, b)
    value = x / (a + b * x);
end
