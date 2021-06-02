clear,clc
syms x;
syms k;
n = 2^6;
F = @(x) sin(2 * pi * x) * exp(cos(2 * pi * x));
l = @(x, k) ((-1)^k) / n * sin(n * pi * x) * cot(pi * (x - k / n));
result=[0:1:1999];
y=[0:1:1999];
delta_y=[0:1:1999];
for i=0:1999
    y(i+1)=F(i/2000);
    tmp=0;

    for j=0:n-1
        tmp=tmp+l(i/2000,j)*F(j/n);
    end
    result(i+1)=tmp;
    delta_y(i+1)=abs(result(i+1)-y(i+1));
end
x=[0:1/2000:1-1/2000];
semilogy(x,delta_y)
%title('Lagrange插值区间上误差值随x变化的情况')
