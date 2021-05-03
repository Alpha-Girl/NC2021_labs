A = [-148, -105, -83, -67;
    488, 343, 269, 216;
    -382, -268, -210, -170;
    50, 38, 32, 29];
q_old = [1; 1; 1; 1];
m = 1000;
epsilon = 10^(-10);
q_old_bar = q_old / abs(max(q_old));
eig(A)

for k = 1:m

    %fprintf("iter:%d", k);

    q_update = A * q_old_bar;
    q_new = A * q_update;
    lamda_square = abs(max(q_new));
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
        q_old_bar = q_update / abs(max(q_update));
    end

end

A = [222, 580, 584, 786;
    -82, -211, -208, -288;
    34, 98, 101, 132;
    -30, -82, -88, -109];
q_old = [1; 1; 1; 1];
m = 1000;
epsilon = 10^(-10);
q_old_bar = q_old / abs(max(q_old));
eig(A)

for k = 1:m

    pause

    q_update = A * q_old_bar
    q_new = A * q_update
    lamda_square = abs(max(q_new));
    q_new_bar = q_new / lamda_square

    if abs(max(q_old_bar - q_new_bar)) < epsilon
        fprintf("lamda:%.16f\nq_new_bar:", sqrt(lamda_square));
        q_new_bar
        break
    elseif abs(max(q_old_bar + q_new_bar)) < epsilon
        fprintf("lamda:%.16f\nq_new_bar:", -sqrt(lamda_square));
        q_new_bar
        break
    else
        q_old_bar = q_update / sqrt(real(max(q_update))^2+imag(max(q_update))^2);
    end

end
fprintf("end!");

