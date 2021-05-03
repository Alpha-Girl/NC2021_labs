clear, clc

A = [2, -1, 0, 0, 0, 0, 0, 0, 0, 0;
    -1, 2, -1, 0, 0, 0, 0, 0, 0, 0;
    0, -1, 2, -1, 0, 0, 0, 0, 0, 0;
    0, 0, -1, 2, -1, 0, 0, 0, 0, 0;
    0, 0, 0, -1, 2, -1, 0, 0, 0, 0;
    0, 0, 0, 0, -1, 2, -1, 0, 0, 0;
    0, 0, 0, 0, 0, -1, 2, -1, 0, 0;
    0, 0, 0, 0, 0, 0, -1, 2, -1, 0;
    0, 0, 0, 0, 0, 0, 0, -1, 2, -1;
    0, 0, 0, 0, 0, 0, 0, 0; -1, 2];
b = [2; -2; 2; -1; 0; 0; 1; -2; 2; -2];
x_exact = [1; 0; 1; 0; 0; 0; 0; -1; 0; 1];
e = 10e-4;
m = 10 * 10;
Q = speye(10);

for i = 1:m
    l = diag(A);
    [s, p, q] = max(abs(A - l));
    if (s < e) 
        print(l);
        print(Q);
        break;
    else
        [A, R] = givens(A, p, q);
        Q = Q * R;
    end
end

function [A, R] = givens(A, p, q)
    Apq = A(p, q);
    App = A(p, p);
    Aqq = A(q, q);

    if Apq != 0 and App = Aqq:
        sint = 1 / sqrt(2);
        cost = 1 / sqrt(2);
    elseif Apq = 0:
        sint = 0;
        cost = 1;
    else:
        delta=(App-Aqq).^2+4*Apq.^2;
        tant1=((App-Aqq)+sqrt(delta))/(2*Apq);
        tant2=((App-Aqq)-sqrt(delta))/(2*Apq);
        if abs(tant1)>abs(tant2):
            tant=tant2;
        else:
            tant=tant1;
        end
        cost=1/sqrt(1+tant.^2);
        sint=cost*tant;
    end
    R=syepe(10);
    R(p,p)=cost;
    R(q,q)=cost;
    R(p,q)=sint;
    R(q,p)=-sint;
    A=A*R;

