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
A = -A; %comment this line to slove 3(b)
% or uncomment to solve 3(c)
% or add minus to solve -A
q_old = [1; 1; 1; 1];
maxrept = 10000;
epsilon = 10^(-15);
q_old_bar = q_old / max(abs(q_old));
% Calculate eigenvalues by Matlab
eig(A)
% Iterations
for i = 1:maxrept
    q_update = A * q_old_bar;
    [~, I] = max(abs(q_update));
    lamda = q_update(I);
    q_new = A * q_update;
    lamda_square = max(abs(q_new));
    q_new_bar = q_new / lamda_square;

    if max(abs(q_old_bar - q_new_bar)) < epsilon & ...
            lamda > 0
        % Print lambda and eigenvector
        fprintf("lamda:%.16f\nq_new_bar:", ...
            sqrt(lamda_square));
        q_new_bar
        break
    elseif max(abs(q_old_bar - q_new_bar)) < epsilon & ...
            lamda < 0
        % Print lambda and eigenvector
        fprintf("lamda:%.16f\nq_new_bar:", ...
            -sqrt(lamda_square));
        q_new_bar
        break
    else
        q_old_bar = q_new_bar;
    end

end

% error case
if i == maxrept + 1
    fprintf("error message");
end
