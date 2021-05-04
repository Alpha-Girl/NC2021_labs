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
R = speye(10) - D \ A;
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

% SOR Part:
% w=0.4:
[count_S_0, x, state] = SOR(1.5, A, x_exact, b);
% w=0.8:
[count_S_1, x, state] = SOR(1.55, A, x_exact, b);
% w=1.2:
[count_S_2, x, state] = SOR(1.6, A, x_exact, b);
% w=1.6:
[count_S_3, x, state] = SOR(1.65, A, x_exact, b);
[count_S_4, x, state] = SOR(1.7, A, x_exact, b);
semilogy([1:length(count_S_0)], count_S_0, ...
    [1:length(count_S_2)], count_S_2, ...
[1:length(count_S_4)], count_S_4);
legend('SOR w=1.5', ...
     'SOR w=1.6', 'SOR w=1.7', ...
    'Location', 'northeast');
xlabel('Iterations');
ylabel('Error size');
title('Error size - Iterations Graph');

text(length(count_S_0), ...
    count_S_0((length(count_S_0))), 'w=1.5');

text(length(count_S_2) , ...
    count_S_2(length(count_S_2)), 'w=1.6');

text(length(count_S_4)/2, ...
    count_S_4(floor(length(count_S_4)/2)), 'w=1.7');
function [count, x, state] = SOR(w, A, x, b)
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
    f = w * inv(speye(10) + w * D_INV * L) * (D_INV * b);
    count = []; % count: used to save the error size
    number = 1; % Iterations

    while abs(max(x_1 - x_2)) > epsilon & number < 1000
        x_1 = x_2;
        x_2 = (S * x_1 + f);
        count(number) = abs(max(x_2 - x_exact)) / tmp;
        number = number + 1;
    end

    if number == 1000
        state = 0
    else
        state = 1
        x_2
    end

end
