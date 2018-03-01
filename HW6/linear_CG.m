%% Linear Conjugate Gradient Method
function [point, output, time, iter] = linear_CG(f, f_residual, A, point, epsilon, max_iter)

tic;
plot_point = zeros(0, 2); % for plot result
before = f(point(1), point(2)); % initial function value

% initial setting
r = double(f_residual(point(1), point(2)))';
p = -r;

for iter=1:max_iter
    if (iter == max_iter)
        % when reach to end of loop, evoke error
        error('Conjugate gradinet method failed!');
    end;
    
    % for plot result
    plot_point(iter, :) = point;
    
    % exact line search
    step_size = (-r' * p) / (p' * A * p);
    
    % update
    point = point + (step_size * p');
    
    % terminate condition
    current = double(f(point(1), point(2)));
    if(abs(current - before) <= epsilon)
        break;
    end;
    before = current;
    
    % residual
    r = double(f_residual(point(1), point(2)))';
    
    % beta update
    b = (r' * A * p) / (p' * A * p);
    
    % next conjugate direction
    p = -r + (b * p);
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
title('Linear CG')