%% Nonlinear Conjugate Gradient Method
function [point, output, time, iter] = nonlinear_CG(f, f_exact, f_gradient, point, epsilon, max_iter)

tic;
v = 0.1; % for orthogonality test
plot_point = zeros(0, 2); % for plot result
before = f(point(1), point(2), point(1), point(2)); % initial function value

% initial setting
r = zeros(2, 2);
r(1, :) = double(f_gradient(point(1), point(2), point(1), point(2)))';
p = -r(1, :);

for iter=1:max_iter
    if (iter == max_iter)
        % when reach to end of loop, evoke error
        error('Conjugate gradinet method failed!');
    end;
        
    % inexact line search for the given search direction (-gradient)
    step_size = 5 * rand(1); % step_size initialization
    step_size = strong_wolfe_search(f, f_gradient, point, step_size, r(1, :), -r(1, :), max_iter);

    % update
    point = point + (step_size * p);
    
    % terminate condition
    current = double(f_exact(point(1), point(2)))
    if(abs(current - before) <= epsilon)
        break;
    end;
    before = current;
    
    % for plot result
    plot_point(iter, :) = point;

    % gradient residual
    r(2, :) = double(f_gradient(point(1), point(2), point(1), point(2)))';
    
    % orthogonality check and beta update
    if ((r(2, :) * r(1, :)') / (r(2, :) * r(2, :)')) >= v
        b = (r(2, :) * r(2, :)') / (r(1, :) * r(1, :)');
    else
        b = 0;
    end;

    % next conjugate direction
    p = -r(2, :) + (b * p);

    % swap
    r(1, :) = r(2, :);
end;

output = double(current);
time = toc;

%% Plot result
figure;
[X, Y] = meshgrid(-1:0.5:2, -1:0.5:2);
Z = f_exact(X, Y);
mesh(X, Y, Z)
alpha(0.1)
hold on;
scatter3(plot_point(:, 1), plot_point(:, 2), f_exact(plot_point(:, 1), plot_point(:, 2)), 100, 'filled', 'MarkerFaceColor', 'r')
for j=1:size(plot_point, 1)-1
    hold on;
    line(plot_point([j, j+1], 1), plot_point([j, j+1], 2), f_exact(plot_point([j, j+1], 1), plot_point([j, j+1], 2)), 'LineWidth', 3, 'Color', 'b')
    view(3)
end;
title('Nonlinear CG')