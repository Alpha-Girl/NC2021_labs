clc, clear;
% Input of 3(c)
B = [222, 580, 584, 786;
    -82, -211, -208, -288;
    37, 98, 101, 132;
    -30, -82, -88, -109];
% Input of 3(b)
A = [-148, -105, -83, -67;
    488, 343, 269, 216;
    -382, -268, -210, -170;
    50, 38, 32, 29];
A = -B; %comment this line to slove 3(b)
% or uncomment to solve 3(c)
% or add minus to solve -A
q_old = [1; 1; 1; 1];
maxrept = 10000;
epsilon = 10^(-15);
q_old_bar = q_old / max(abs(q_old));
% Calculate eigenvalues by Matlab
eig(A)
% Iterations
flag = 0;

for i = 1:maxrept
    q_update = A * q_old_bar;
    q_new = A * q_update;
    lambda_square = max(abs(q_new));
    q_new_bar = q_new / lambda_square;

    if max(abs(q_old_bar - q_new_bar)) < epsilon
        % Print lambda and eigenvector
        lambda = sqrt(lambda_square);
        vec = q_update + lambda * q_old_bar;

        if max(abs(vec)) > 1
            fprintf("lambda:%.16f\nq_new_bar:", lambda);
            vec = vec / max(abs(vec))
        end

        vec = q_update - lambda * q_old_bar;

        if max(abs(vec)) > 1
            fprintf("lambda:%.16f\nq_new_bar:", -lambda);
            vec = vec / max(abs(vec))
        end

        break
    end

    q_old_bar = q_new_bar;

end

% error case
if i == maxrept + 1
    fprintf("error message");
end
