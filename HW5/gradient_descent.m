%% Gradient descent
function [point, output, time, iter] = gradient_descent(f, f_gradient, point, epsilon, max_iter)

tic;
plot_point = zeros(0, 2); % for plot result
before = f(point(1), point(2)); % initial function value

for iter=1:max_iter
    if (iter == max_iter)
        % when reach to end of loop, evoke error
        error('Steepest gradinet descent failed!');
    end;
    
    % for plot result
    plot_point(iter, :) = point;
    
    % compute gradient
    gradient = double(f_gradient(point(1), point(2)))';
    
    % inexact line search for the given search direction (-gradient)
    step_size = 5 * rand(1); % step_size initialization
    step_size = inexact_search(f, point, step_size, gradient, -gradient, max_iter);
    
    % update point
    point = point - (step_size * gradient);
    
    % terminate condition
    current = f(point(1), point(2));
    if(abs(current - before) <= epsilon)
        break;
    end;
    before = current;
end;

output = double(current);
time = toc;

%% Plot result
figure;
[X, Y] = meshgrid(-3:0.5:2, -3:0.5:1);
Z = f(X, Y);
mesh(X, Y, Z)
alpha(0.1)
hold on;
scatter3(plot_point(:, 1), plot_point(:, 2), f(plot_point(:, 1), plot_point(:, 2)), 100, 'filled', 'MarkerFaceColor', 'r')
for j=1:size(plot_point, 1)-1
    hold on;
    line(plot_point([j, j+1], 1), plot_point([j, j+1], 2), f(plot_point([j, j+1], 1), plot_point([j, j+1], 2)), 'LineWidth', 3, 'Color', 'b')
    view(3)
end;
title('Steepest Gradient Descent')