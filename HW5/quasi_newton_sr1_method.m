%% Quasi Newton's SR1 method
function [point, output, time, iter] = quasi_newton_sr1_method(f, f_gradient, point, epsilon, max_iter)

tic;
r = 1E-8; % checking SR1 breaking rule constant
plot_point = zeros(0, 2); % for plot result
before = f(point(1), point(2)); % initial function value
Hk = eye(size(point, 2)); % initial inverse Hessian approximation
gradient = double(f_gradient(point(1), point(2))); % first gradient
    
for iter=1:max_iter
    if (iter == max_iter)
        % when reach to end of loop, evoke error
        error('Quasi Newton''s method failed!');
    end;
    
    % for plot result
    plot_point(iter, :) = point;
    
    % inexact line search for the given search direction (-gradient)
    step_size = 5 * rand(1); % step_size initialization
    step_size = inexact_search(f, point, step_size, gradient, -(Hk * gradient)', max_iter);
    
    % Quasi Newton - SR1 update
    point = point - (step_size * Hk * gradient)';
    
    % terminate condition
    current = f(point(1), point(2));
    if(abs(current - before) <= epsilon)
        break;
    end;
    before = current;
    
    % gradient
    gradient = double(f_gradient(point(1), point(2)));

    % compute pk
    pk = Hk * -gradient;
    
    % compute yk, sk
    next_point = point + (step_size * pk');
    yk = double(f_gradient(next_point(1), next_point(2))) - gradient;
    sk = step_size * pk;
    
    % check SR1 breaking down for inverse matrix Hk, and SR1 update
    if abs(((sk - (Hk * yk))' * yk)) >= r * sqrt(sum((sk - (Hk * yk)) .^ 2)) * sqrt(sum(yk .^ 2))
        Hk = Hk + (((sk - (Hk * yk)) * (sk - (Hk * yk))') / ((sk - (Hk * yk))' * yk));
    end;
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
title('Quasi Newton''s SR1 Method')