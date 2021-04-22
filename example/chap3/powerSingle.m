% Compute the maximum of eigenvalues of a matrix using power method.

clear, clc

% matrix
A = [9, 1;
     1, 2];
 
% initialization
q = ones(size(A, 1), 1);
qbar = q/norm(q, inf);
tol = 1e-12;

% the maximum of iterations
m = 20;   

fprintf('iter.                  |lambda|               log(||qoldbar - qnewbar||)\n')
dashString = repmat('-', 1, 90);
fprintf('%s\n', dashString);

for k = 1:m
    qnew = A*qbar;
    abslambda = norm(qnew, inf);
    qnewbar = qnew/norm(qnew, inf);
    fprintf(sprintf('%3d %26.16f    %22.16f \n', k, abslambda,...
            log10(norm(qnewbar - qbar, inf))))
    if (norm(qnewbar - qbar, inf) < tol || norm(qnewbar + qbar, inf) < tol)
        if (norm(qnewbar - qbar, inf) < tol)
            lambda = abslambda;
            break
        else
            lambda = - abslambda;  %  negative eigenvalue
            break
        end
    end
    qbar = qnewbar; q = qnew;
end

eigm = max(eig(A));
[vect, ~] = eig(A); 
vect(:,2) = vect(:,2)/max(abs(vect(:,2)));
fprintf('%s\n', dashString);
fprintf('eigenvalue: \nlambda = %18.16f\n \n',lambda);
fprintf('Matlab: %18.16f\n',eigm);
fprintf('%s\n', dashString);
fprintf('eigenvector:\n')
fprintf('qnewbar = (%18.16f,%18.16f)^T\n\n',qnewbar(1),qnewbar(2))
fprintf('Matlab: (%18.16f,%18.16f)^T\n',vect(1,2),vect(2,2))