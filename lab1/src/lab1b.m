clear, clc

A = [2, -1, 0, 0, 0, 0, 0, 0, 0, 0;
    -1, 2, -1, 0, 0, 0, 0, 0, 0, 0;
    0, -1, 2, -1, 0, 0, 0, 0, 0, 0;
    0, 0, -1, 2, -1, 0, 0, 0, 0, 0;
    0, 0, 0, -1, 2, -1, 0, 0, 0, 0;
    0, 0, 0, 0, -1, 2, -1, 0, 0, 0;
    0, 0, 0, 0, 0, -1, 2, -1, 0, 0;
    0, 0, 0, 0, 0, 0, -1, 2, -1, 0;
    0, 0, 0, 0, 0, 0, 0, -1, 2, -1;
    0, 0, 0, 0, 0, 0, 0, 0, -1, 2];
b = [2; -2; 2; -1; 0; 0; 1; -2; 2; -2];
x_exact = [1; 0; 1; 0; 0; 0; 0; -1; 0; 1];
tmp = abs(max(x_exact));
x_1 = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0];
x_2 = [1; 1; 1; 1; 1; 1; 1; 1; 1; 1];
L = tril(A, -1);
U = triu(A, 1);
D = diag(diag(A));
D_INV = inv(D);

w = 1.5;
S = (speye(10) + w * D_INV * L) \ (speye(10) - w * (D_INV * U + speye(10)));
f = w * inv(speye(10) + w * D_INV * L) * (D_INV * b);
count = [];
number = 1;

while abs(max(x_1 - x_2)) > 10^(- 15) & number < 1000
    x_1 = x_2;
    x_2 = (S * x_1 + f);
    count(number) = abs(max(x_2 - x_exact)) / tmp;
    number = number + 1;
end

semilogy(count);
x = x_2
