% Compute the maximum of modules of eigenvalues of a matrix using power
% method, where the matrix has two eigenvalues of maximum module having
% opposite signs.

clear, clc

% the matrix
A = [ 4,-1,  1;
     16,-2, -2;
     16,-3, -1];
 
 % initialization
a = [1;2;4];
b = [3;4;1];
abar = a/norm(a, inf);
bbar = b/norm(b, inf);
c = A*abar;
cbar = c/norm(c, inf);
tol = 1e-11;

% the maximum of iterations
m = 30;   

fprintf(['iter.               |lambda|                     log(||dbar - bbar||) ' ...
    '             log(||cbar - abar||)\n'])
dashString = repmat('-', 1, 120);
fprintf('%s\n', dashString);

for k = 1:m
    d = A*cbar;
    dbar = d/norm(d, inf);
        fprintf(sprintf('%3d %24.16f    %22.16f     %22.16f\n',...
            k, sqrt(norm(d, inf) * norm(c, inf)), log10(norm(dbar - bbar, inf)),...
            log10(norm(cbar - abar, inf))))
    if (norm(dbar - cbar, inf) < tol || norm(dbar + cbar, inf) < tol)
        % single eigenvalue
        if (norm(dbar - cbar, inf) < tol)
            lambda = norm(d, inf);
            mu = dbar;
            break
        else
            lambda = - norm(d, inf);
            mu = dbar;
            break
        end
    elseif (norm(dbar - bbar, inf) < tol && norm(cbar - abar, inf) < tol)
        % pair of real eigenvalues
        lambda1 = sqrt(norm(d, inf) * norm(c, inf));
        lambda2 = - lambda1;
        vplus = lambda1*cbar + d;     % eigenvector
        vminus = lambda1*cbar - d;
        break
    elseif (norm(dbar + bbar, inf) < tol && norm(cbar + abar, inf) < tol)
        % pair of pure image eigenvalues
        lambda1 = sqrt(norm(d, inf) * norm(c, inf))*1i;
        lambda2 = - lambda1;
        vplus = lambda1*cbar + d;
        vminus = lambda1*cbar - d;
        break
    end
    a = b; abar = bbar; b = c; bbar = cbar; c = d; cbar = dbar;
end

eigmax = max(eig(A));
eigmin = min(eig(A));
[vect, ~] = eig(A);
vplus = vplus/norm(vplus,inf);
vminus = vminus/norm(vminus,inf);
vect(:,1) = vect(:,1)/norm(vect(:,1),inf);
vect(:,2) = vect(:,2)/norm(vect(:,2),inf);

fprintf('%s\n', dashString);
fprintf('eigenvalue: \n');
fprintf('lambda = %18.16f   -lambda = %18.16f\n\n',...
      lambda1,-lambda1);
fprintf('   Matlab: %18.16f  %22.16f\n',eigmax,eigmin)
fprintf('%s\n', dashString);
fprintf('eigenvector: \n')
fprintf('v+ = (%18.16f, %18.16f, %18.16f)^T\n',...
    vplus(1),vplus(2),vplus(3));
fprintf('v- = (%18.16f, %18.16f, %18.16f)^T\n\n',...
    vminus(1),vminus(2),vminus(3));
fprintf('Matlab: \n')
fprintf('(%18.16f, %18.16f,  %18.16f)^T\n',...
    vect(1,1), vect(2,1),vect(3,1));
fprintf('(%18.16f, %18.16f,  %18.16f)^T\n',...
    vect(1,2), vect(2,2),vect(3,2));

