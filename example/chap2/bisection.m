% Find the solutions of the equation f(x) = 0 using bisection method, 
% where f(x) = e^x - x - 2.

clear, clc

% The function to be solved
f = @(x) exp(x) - x - 2;

% The initial interval
% a = -3; b = -1;  sol = -1.8414056604369606378;
% a = 0.2; b = 2;  sol = 1.1461932206205825852;
a = 0; b = 3;  sol = -1.8414056604369606378;
fprintf('initial value: a = %8.6f, b = %8.6f \n',a,b);
dashString = repmat('-', 1, 50);
fprintf('iter.        a                   b\n')
fprintf('%s\n', dashString);
fa = f(a);

% Set the tolerance
tol = 1e-3;

% The number of iteration
ite = 0;

LW = 'LineWidth'; lw1 = 2; lw2 = 0.5;
FS = 'fontsize'; fs = 12;
figure;
set(gcf,'position',[600,85,900,650])
a0 = min(-4,min(a,b)); b0 = max(3,max(a,b)); %The plot interval
fplot(f, [a0 b0], LW, lw1); hold on
scatter(a,0,'filled','r'); hold on
ta = text(a-0.015, -0.05,'a',FS,fs);
scatter(b,0,'filled','r'); hold on
tb = text(b-0.015, -0.05,'b',FS,fs);
axis([a0 b0 -1 1]);
title('Bisection')
plot([a0, b0],[0, 0], LW, lw2, 'Color', 'black'); hold on

% Check the sign of f(a) and f(b)
if f(a) == 0
    meg = sprintf('%12.6f is the root.',a);
    disp(meg)
end
if f(b) == 0
    meg = sprintf('%12.6f is the root.',b);
    disp(meg)
end
if f(a)*f(b)>0
    error('f(a) and f(b) have the same sign!')
end

% Do the bisection
while abs(a - b) > tol
    pause;
    ite = ite + 1;
    c = (a + b)/2;
    fc = f(c);
    if sign(fc) == sign(fa)
        if abs(c - b) > 0.012*(b0 - a0)
            delete(ta);
            ta = text(c-0.015, -0.05,'a',FS,fs);
        end
        a = c;
        scatter(a,0,'filled','r'); hold on
        axis([a0 b0 -1 1]);
    else 
        if abs(c - a) > 0.012*(b0 - a0)
            delete(tb);
            tb = text(c-0.015, -0.05,'b',FS,fs);
        end
        b = c;
        scatter(b,0,'filled','r'); hold on
        axis([a0 b0 -1 1]);
    end
    fprintf('%2d %12.6f  %12.6f \n',ite,a,b);
end
fprintf('%s\n', dashString);
fprintf('True solution: x = %8.6f\n',sol)