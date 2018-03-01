%% Gauss-Newton method
function [cost_after, W, time, iter] = gaussNewton(f, R, J, W, data, epsilon, max_iter)

tic;
cost_before = 0;

% for plot results
not_trained_W = W;

for iter=1:max_iter
    % comptue residual
    residual_mat = double(R(W(1), W(2), W(3), W(4), data(:, 1), data(:, 2), data(:, 3), data(:, 4)));
    
    % cost function
    cost_after = (1/2) * sum(residual_mat .^ 2);
    
    % termination condtion
    if abs(cost_after - cost_before) < epsilon
        break;
    end;
    cost_before = cost_after;
    
    % compute jacobian
    for i=1:size(data, 1)
        jacobian_mat(i, :) = double(J(W(1), W(2), W(3), W(4), data(i, 1), data(i, 2), data(i, 3), data(i, 4)));
    end;
    
    % search direction
    p = -(jacobian_mat' * jacobian_mat) \ jacobian_mat' * residual_mat;
            
    % weight update
    W = W + p';
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
title('Gauss-Newton method')