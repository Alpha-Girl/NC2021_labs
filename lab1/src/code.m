clear, clc;
% The value of A and B:
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
epsilon = 10^(-15);
% Jacobi Part:
x_exact = [1; 0; 1; 0; 0; 0; 0; -1; 0; 1];
tmp = abs(max(x_exact));
x_1 = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0];
x_2 = [1; 1; 1; 1; 1; 1; 1; 1; 1; 1];
% initialization
D = diag(diag(A));
R = speye(10) - D \ A
spy(R)
g = D \ b;
count_J = []; % count: used to save the error size
number_J = 1; % Iterations

while abs(max(x_1 - x_2)) > epsilon
    x_1 = x_2;
    x_2 = R * x_1 + g;
    count_J(number_J) = abs(max(x_2 - x_exact)) / tmp;
    number_J = number_J + 1;
end

% Print the output of Jacobi
x = x_2

% Gauss-Siedel Part:
x_1 = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0];
x_2 = [1; 1; 1; 1; 1; 1; 1; 1; 1; 1];
% initialization
L = tril(A, -1);
U = triu(A, 1);
D = diag(diag(A));
S = -(D + L) \ U
spy(S)
f = (D + L) \ b;
count_G = []; % count: used to save the error size
number_G = 1; % Iterations

while abs(max(x_1 - x_2)) > epsilon
    x_1 = x_2;
    x_2 = S * x_1 + f;
    count_G(number_G) = abs(max(x_2 - x_exact)) / tmp;
    number_G = number_G + 1;
end

% Print the output of Gauss-Siedel
x = x_2

syms w;
    x_exact = x;
    tmp = abs(max(x_exact));
    x_1 = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0];
    x_2 = [1; 1; 1; 1; 1; 1; 1; 1; 1; 1];
    % initialization
    L = tril(A, -1);
    U = triu(A, 1);
    D = diag(diag(A));
    D_INV = inv(D);
    epsilon = 10^(-15);
    S = (speye(10) + w * D_INV * L) \ ...
        (speye(10) - w * (D_INV * U + speye(10)));
    spy(S);
