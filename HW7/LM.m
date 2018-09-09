%% LM method
function [cost_after, W, time, iter] = LM(f, R, J, W, data, epsilon, max_iter)

tic;
flag = 0; % for lambda update, flag = 1 => satisfying descent condition, flag = 0 => unsatisfying the condition
cost_before = 0; % for terminating cost
lambda = rand(1); % initialize lambda

% for plot results
not_trained_W = W;

for iter=1:max_iter
    % comptue residual
    residual_mat = double(R(W(1), W(2), W(3), W(4), data(:, 1), data(:, 2), data(:, 3), data(:, 4)));
    
    % cost function
    cost_after = (1/2) * sum(residual_mat .^ 2)
    
    % termination condtion
    if abs(cost_after) < epsilon
        break;
    end;
    cost_before = cost_after;
    
    % compute jacobian
    for i=1:size(data, 1)
        jacobian_mat(i, :) = double(J(W(1), W(2), W(3), W(4), data(i, 1), data(i, 2), data(i, 3), data(i, 4)));
    end;
    
    for j=1:max_iter
        % search direction
        p = -((jacobian_mat' * jacobian_mat) + (lambda * eye(4))) \ jacobian_mat' * residual_mat;

        % temporarily weight update
        W_temp = W + p';
        
        % check residual value for lambda adjustment
        val = abs(double(R(W(1), W(2), W(3), W(4), data(:, 1), data(:, 2), data(:, 3), data(:, 4))));
        temp_val = abs(double(R(W_temp(1), W_temp(2), W_temp(3), W_temp(4), data(:, 1), data(:, 2), data(:, 3), data(:, 4))));

        if(all(val >= temp_val) == 1) % satisfying descent condition
            flag = 1;
            lambda = lambda / 10;
            if(lambda < 1E-6) % lambda should be < 1E-5 (custom condition)
                W = W_temp;
                break;
            end;
        elseif((all(val >= temp_val) == 0) && (flag == 0)) % unsatisfying descent condition
            lambda = lambda * 10;
            if(lambda > 1E6) % lambda should be > 1E5 (custom condition)
                W = W_temp;
                break;
            end;
        elseif((all(val >= temp_val) == 0) && (flag == 1)) % unsatisfying descent condition, but satisfied in previous step
            break;
        end;
    end;
end;

time = toc;

%% Plot Results
figure;
plot(data(:, 4), 'b--o', 'LineWidth', 1.5)
hold on;
plot(f(W(1), W(2), W(3), W(4), data(:, 1), data(:, 2), data(:, 3)), 'r--o', 'LineWidth', 1.5)
hold on;
plot(f(not_trained_W(1), not_trained_W(2), not_trained_W(3), not_trained_W(4), data(:, 1), data(:, 2), data(:, 3)), 'g--o', 'LineWidth', 1.5)
legend('real value', 'trained value', 'not trained value')
title('LM method')