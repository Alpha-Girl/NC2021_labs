clc, clear
A = [-148, -105, -83, -67;
    488, 343, 269, 216;
    -382, -268, -210, -170;
    50, 38, 32, 29];
q_old = [1; 1; 1; 1];
m = 1000;
epsilon = 10^(-10);
magnitude = abs(q_old);
[~, I] = max(magnitude);
q_old_bar = q_old / q_old(I);
eig(A)

for k = 1:m

    %fprintf("iter:%d", k);

    q_update = A * q_old_bar;
    q_new = A * q_update;
    magnitude = abs(q_new);
    [~, I] = max(magnitude);
    lamda_square = q_new(I);
    q_new_bar = q_new / lamda_square;

    if abs(max(q_old_bar - q_new_bar)) < epsilon
        fprintf("lamda:%.16f\nq_new_bar:", sqrt(lamda_square));
        q_new_bar
        break
    elseif abs(max(q_old_bar + q_new_bar)) < epsilon
        fprintf("lamda:%.16f\nq_new_bar:", -sqrt(lamda_square));
        q_new_bar
        break
    else
        q_old_bar = q_new_bar;
    end

end

A = [222, 580, 584, 786;
    -82, -211, -208, -288;
    34, 98, 101, 132;
    -30, -82, -88, -109];
q_old = [1; 1; 1; 1];
m = 1000;
epsilon = 10^(-10);
magnitude = abs(q_old);
[~, I] = max(magnitude);
q_old_bar = q_old / q_old(I);
eig(A)

for k = 1:m

    %fprintf("iter:%d", k);

    q_update = A * q_old_bar;
    q_new = A * q_update;
    magnitude = abs(q_new);
    [~, I] = max(magnitude);
    lamda_square = q_new(I);
    q_new_bar = q_new / lamda_square;

    if abs(max(q_old_bar - q_new_bar)) < epsilon
        fprintf("lamda:%.16f\nq_new_bar:", sqrt(lamda_square));
        q_new_bar
        break
    elseif abs(max(q_old_bar + q_new_bar)) < epsilon
        fprintf("lamda:%.16f\nq_new_bar:", -sqrt(lamda_square));
        q_new_bar
        break
    else
        q_old_bar = q_update / sqrt(lamda_square);
    end

end

fprintf("end!");
