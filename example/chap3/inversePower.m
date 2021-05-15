% Solving the eigenvalue of matrix west0479 which is near 15 + 35i using
% inverse power iteration.

clear, clc

load west0479;
A = west0479;

n = 479;
itnum = 20; % number of iteration
iterate = zeros(n, itnum + 1);
scale_factor = zeros(itnum + 1,1);
shift = 15 + 35i;
[L, U ,P] = lu(A - shift*speye(n));
q = randn(n, 1); % random starting vector
[~, index] = max(abs(q));
scale_factor(1) = q(index(1));
q = q/scale_factor(1);
iterate(:, 1) = q;

tol = 1e-12;
east = 17.548546093831114 +34.237822957500022i;

fprintf(['iter.                                    lambda             '...
         '                          log of ||qoldbar - qnewbar||\n'])
dashString = repmat('-', 1, 120);
fprintf('%s\n', dashString);

for j = 1:itnum
    % apply the inverse of A by solving a linear system
    qnew = P*q;
    qnew = L\qnew;
    qnew = U\qnew;
    [~, index] = max(abs(qnew));
    scale_factor(j+1) = qnew(index(1));
    qnew = qnew/scale_factor(j + 1);
    iterate(:, j+1) = qnew;
    fprintf(sprintf(['%3d %26.16f +%18.16f' 'i' '  %23.14f \n'],...
            j, real(shift + 1/scale_factor(j + 1)),...
            imag(shift + 1/scale_factor(j + 1)), log10(norm(qnew - q, inf))))
    if norm(q - qnew, inf) < tol
        break
    end
    q = qnew;
end
fprintf('%s\n', dashString)
fprintf(['Matlab: %19.16f +%18.16f' 'i\n'],real(east),imag(east))
% format long
% eigval = shift + 1./scale_factor
