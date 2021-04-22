% Find the solutions of the equation f(x) = 0 using fixed point method, 
% where f(x) = e^x - x - 2.

clear, clc

% The initial guess
x = 3; sol = 1.1461932206205825852;
% x = -0.5; sol = -1.8414056604369606378;

fprintf('initial : x = %8.7f\n',x)
fprintf('iter.        x                      log(|err|)             mu \n');
dashString = repmat('-', 1, 70);
fprintf('%s\n', dashString);
% Set the tolerance
tol = 1e-5;

% The number of iteration
ite = 0;

% The different forms equivalent to f(x) which guarantee the convergence
if x > 0
    g = @(x) log(x + 2); gstr = 'y = log(x+2)';
else
    g = @(x) exp(x) - 2; gstr = 'y = e^x - 2';
end

% The plotting part
LW = 'LineWidth'; lw1 = 2; lw2 = 0.5;
LS = 'LineStyle'; ls = '--';
FS = 'fontsize'; fs = 12;
figure;
set(gcf,'position',[600,85,900,650])
xmin = min(x - 0.5, -3); xmax = max(x + 0.5, 2);  % Get the region
fplot(g, [xmin xmax], LW ,lw1); hold on
fplot(@(x) x, [xmin xmax], LW ,lw1,'Color',[0,1,0]); hold on
legend(gstr,'y = x', 'Location','best','FontSize',20);
axis([xmin xmax -2.2 g(xmax)]);
xscale = xmax - xmin; yscale = g(xmax) + 2.2;
title('Fixed point')
scatter(x,0,'filled','r','HandleVisibility','off'); hold on
xite = ['x' sprintf('%d',ite)]; xsign = sign(-g(x));
text(x-0.01*xscale, xsign*yscale*0.022, xite, FS, fs);
plot([xmin, xmax],[0, 0], LW, lw2, 'Color', 'black','HandleVisibility','off'); 
hold on

err = 0; % store the sequence of errors
% do the iteration
while 1
    pause
    ite = ite + 1;
    xnew = g(x);
    err = [err;abs(xnew - sol)];
    logerr = log10(err(ite + 1));
    if ite > 2
        mu = (err(ite + 1) - err(ite))/(err(ite) - err(ite - 1));
        fprintf('%2d %15.7f %18.8f        %6.3f\n',...
            ite,xnew,logerr,mu);
    else
        fprintf('%2d %15.7f %18.8f        \n',...
            ite,xnew,logerr);
    end
    plot([xnew, xnew],[xnew, 0], ...
        LW, lw2, LS, ls, 'Color', 'black','HandleVisibility','off'); hold on
    if ite == 1
        plot([x, x],[0, xnew], LW, lw2, LS, ls, 'Color', 'black',...
             'HandleVisibility','off'); hold on
        plot([x, xnew],[xnew, xnew], LW, lw2, 'Color', 'm',...
             'HandleVisibility','off');
    else
        plot([x, x, xnew],[x, xnew, xnew], LW, lw2, 'Color', 'm',...
            'HandleVisibility','off');
    end
    scatter(xnew,0,'filled','r','HandleVisibility','off'); hold on
    if abs(xnew - x) > 0.03*xscale
        xite = ['x' sprintf('%d',ite)];
        text(xnew-0.01*xscale, xsign*yscale*0.022, xite, FS, fs);
    end
    if abs(xnew - sol) < tol
        fprintf('%s\n', dashString);
        fprintf('True solution: x = %8.7f\n',sol)
        break
    else
        x = xnew;
    end
end