% Computes the eigenvalues of a symmetric matirx by Jacobi method.

clear, clc

% the matrix
A = [4, 1, 2, 1, 2;
    1, 3, 0,-3, 4;
    2, 0, 1, 2, 2;
    1,-3, 2, 4, 1;
    2, 4, 2, 1, 1];

% real soluton
eigval = eig(A);
[vect, ~] = eig(A);

 fprintf('iter.          largest off-diagonal entry        location\n')
 dashString = repmat('-', 1, 90);
 fprintf('%s\n', dashString);
 
 tol = 1e-12;
 ite = 0;
 lag = 1; % store the largest entry
 
 % store the eigenvectors
 M = eye(size(A));
 
 % the classical Jacobi iteration
 while abs(lag) > tol
     ite = ite + 1;
     C = abs(A - diag(diag(A)));
     [max1, idx] = max(C);
     [~, q] = max(max1);
     p = idx(q);
     lag = A(p,q);
     s = (A(q,q) - A(p,p))/(2*A(p,q));
     if s == 0
         t = 1;
     else
         t1 = -s - sqrt(s^2 + 1);
         t2 = -s + sqrt(s^2 + 1);
         if abs(t1) > abs(t2)
             t = t2;
         else
             t = t1;
         end
     end
     c = 1/sqrt(1 + t^2);  % cos(\phi)
     d = t/sqrt(1 + t^2);   % sin(\phi)
     B = A;
     B(p,q) = 0;  B(q, p) = 0;
     for i = 1:5
         if ~(i == p || i == q)
             B(i,p) = c*A(p,i) - d*A(q,i);
             B(p,i) = B(i,p);
             B(i,q) = c*A(q,i) + d*A(p,i);
             B(q,i) = B(i,q);
         end
     end
     B(p,p) = A(p,p) - t*A(p,q);
     B(q,q) = A(q,q) + t*A(p,q);
     
     % the eigenvectors
     Mp = M(:,p)*c - M(:,q)*d;
     Mq = M(:,p)*d + M(:,q)*c;
     M(:,p) = Mp;
     M(:,q) = Mq;
     
     A = B;
     fprintf('%5d%32.16f              (%d,%d)\n', ...
         ite, lag, p,q);
 end
 
 fprintf('%s\n', dashString);
 fprintf('eigenvalues: \n')
 [sA, ind] = sort(diag(A));
 
 fprintf('            Jacobi                                 Matlab  \n')
 for i1 = 1:length(eigval)
     fprintf('%18.16f%26.16f \n',sA(i1), eigval(i1));
 end
 
 fprintf('%s\n', dashString);
 fprintf('eigenvector (of the largest eigenvalue)  \n');
 fprintf('            Jacobi                                 Matlab  \n')
 for j1 = 1:size(A, 1)
     fprintf('%18.16f%26.16f\n',M(j1,ind(5)),vect(j1,5));
 end