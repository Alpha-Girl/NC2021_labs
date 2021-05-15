% Lagrange polynomial, a.k.a. Cardinal polynomial or fundamental polynomial

clear, clc, clf

MS = 'markersize';
ms = 15;
LW = 'linewidth';
lw = 2;
FS = 'fontsize';
fs = 18;

x = linspace(-1, 1, 10);
v = [zeros(1, 3) 1 zeros(1, 6)];
f = polyfit(x, v, 9);
xx = linspace(-1, 1, 1000);
vv = polyval(f, xx);
plot(x, zeros(1, 10), 'b.', MS, ms), hold on
plot(x, v, 'r*', MS, ms)
plot(xx, vv, 'k', LW, lw)
legend('interpolation points', 'Zero but at one interpolation point ', ...
    'Lagrange polynomial', 'location', 'ne')
