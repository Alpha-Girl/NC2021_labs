clc, clear
rng(2);
A = rand(100);
e = eig(A);
lamda = 0.8 - 0.6i;
[~, I] = min(e - lamda * ones(100, 1));
fprintf("The answer must be ");
e(I)

x_k = ones(100, 1);
m = 10000;
epsilon = 10^(-10);

[L, U] = lu(A - lamda * speye(100));
miu_0 = 0;

for i = 1:100
    z_k = L \ x_k;
    y_k = U \ z_k;
    x_new = y_k / norm(y_k, 2);
    miu = dot(x_new, A * x_new);
    i
    if max(abs(miu - miu_0)) < epsilon
        fprintf("lamda:\n");
        miu
        fprintf("x\n");
        x_new
        break
    else
        miu_0 = miu;
        x_k = x_new;
    end

end
