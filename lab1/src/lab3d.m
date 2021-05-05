clc, clear;
% get 100*100 random matrix
rng(2);
A = rand(100);
% find out the eigenvalue next to lamda by Matlab
e = eig(A);
lamda = 0.8 - 0.6i;
[~, I] = min(e - lamda * ones(100, 1));
fprintf("The answer must be ");
% Print it
e(I)
% find out the eigenvalue next to lamda by my program
% initialization
x_k = ones(100, 1);
m = 100;
epsilon = 10^(-15);
% LU decomposition
[L, U] = lu(A - lamda * speye(100));
% to store the answer
miu_0 = 0;

for i = 1:m
    % caculate y_k=(A-lamda*I)^(-1)*x_k
    z_k = L \ x_k;
    y_k = U \ z_k;
    x_new = y_k / norm(y_k, 2);
    % caculate new miu
    miu = dot(x_new, A * x_new);
    % convergence or not
    if max(abs(miu - miu_0)) < epsilon
        %Print eigenvalue
        fprintf("lambda=\n");
        miu
        %Print eigenvector
        fprintf("x=\n");
        x_new_bar = x_new / max(abs(x_new))
        break
    else
        miu_0 = miu;
        x_k = x_new;
    end

end
