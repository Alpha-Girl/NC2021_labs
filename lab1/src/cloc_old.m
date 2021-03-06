
% The value of A and B:
for k = 0:1000

    if k == 1
        tic
    end

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
    % Jacobi Part:
    x_exact = [1; 0; 1; 0; 0; 0; 0; -1; 0; 1];
    tmp = abs(max(x_exact));
    x_1 = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0];
    x_2 = [1; 1; 1; 1; 1; 1; 1; 1; 1; 1];
%     % initialization
    D = diag(diag(A));
    R = speye(10) - D \ A;
    g = D \ b;
    count_J = []; % count: used to save the error size
    number_J = 1; % Iterations

    while abs(max(x_1 - x_2)) > 10^(- 15)
        x_1 = x_2;
        x_2(1) = R(1, 2) * x_1(2);

        for i = 2:9
            x_2(i) = R(i, i - 1) * x_1(i - 1) + R(i, i + 1) * x_1(i + 1);
        end

        x_2(10) = R(10, 9) * x_1(9);
        x_2 = x_2 + g;
        %x_2 = R * x_1 + g;
        count_J(number_J) = abs(max(x_2 - x_exact)) / tmp;
        number_J = number_J + 1;
    end
% 
%     semilogy([1:length(count_J)], count_J);
%     Print the output of Jacobi
%     x = x_2
% 
%     Gauss-Siedel Part:
%     x_1 = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0];
%     x_2 = [1; 1; 1; 1; 1; 1; 1; 1; 1; 1];

%     L = tril(A, -1);
%     U = triu(A, 1);
%     D = diag(diag(A));
%     S = -(D + L) \ U;
%     f = (D + L) \ b;
%     count_G = [];
%     number_G = 1;
% 
%     while abs(max(x_1 - x_2)) > 10^(- 15)
%         x_1 = x_2;
% 
%         for i = 1:9
%             x_2(i) = 0;
% 
%             for j = 2:i + 1
%                 x_2(i) = x_2(i) + S(i, j) * x_1(j);
%             end
% 
%         end
% 
%         x_2(10) = 0;
% 
%         for j = 2:10
%             x_2(10) = x_2(10) + S(10, j) * x_1(j);
%         end
% 
%         x_2 = x_2 + f;
%         count_G(number_G) = abs(max(x_2 - x_exact)) / tmp;
%         number_G = number_G + 1;
%     end

%     Print the output of Gauss-Siedel
%     x = x_2
% 
%     SOR Part:
%     w=0.4:
%     [count_S_0, x, state] = SOR(0.4, A, x_exact, b);
%     w=0.8:
%     [count_S_1, x, state] = SOR(0.8, A, x_exact, b);
%     w=1.2:
%     [count_S_2, x, state] = SOR(1.2, A, x_exact, b);
%     w=1.6:
%     [count_S_3, x] = SOR(1.6, A, x_exact, b);
%     semilogy([1:length(count_J)], count_J, [1:length(count_G)], count_G, [1:length(count_S_0)], count_S_0, [1:length(count_S_1)], count_S_1, [1:length(count_S_2)], count_S_2, [1:length(count_S_3)], count_S_3);
%     legend('Jacobi', 'Gauss-Siedel', 'SOR w=0.4', 'SOR w=0.8', 'SOR w=1.2', 'SOR w=1.6', 'Location', 'northeast');
%     xlabel('Iterations');
%     ylabel('Error size');
%     title('Error size - Iterations Graph');
end

toc

function [count, x] = SOR(w, A, x, b)
    %myFun - Description
    %
    % Syntax: count = myFun(input)
    %
    x_exact = x;
    tmp = abs(max(x_exact));
    x_1 = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0];
    x_2 = [1; 1; 1; 1; 1; 1; 1; 1; 1; 1];
    % initialization
    L = tril(A, -1);
    U = triu(A, 1);
    D = diag(diag(A));
    D_INV = inv(D);

    S = (speye(10) + w * D_INV * L) \ (speye(10) - w * (D_INV * U + speye(10)));
    f = w * inv(speye(10) + w * D_INV * L) * (D_INV * b);
    count = [];
    number = 1;

    while abs(max(x_1 - x_2)) > 10^(- 15) & number < 1000
        x_1 = x_2;

        for i = 1:9
            x_2(i) = 0;

            for j = 1:i + 1
                x_2(i) = x_2(i) + S(i, j) * x_1(j);
            end

        end

        x_2(10) = 0;

        for j = 1:10
            x_2(10) = x_2(10) + S(10, j) * x_1(j);
        end

        x_2 = x_2 + f;
        count(number) = abs(max(x_2 - x_exact)) / tmp;
        number = number + 1;
    end

%     if number == 1000
%         state = 0;
%     else
%         state = 1;
%         x_2;
%     end

end
