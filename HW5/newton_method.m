%% Newton's method
function [point, output, time, iter] = newton_method(f, f_gradient, f_hessian, point, epsilon, max_iter)

tic;
plot_point = zeros(0, 2); % for plot result
before = f(point(1), point(2)); % initial function value

for iter=1:max_iter
    if (iter == max_iter)
        % when reach to end of loop, evoke error
        error('Newton''s method failed!');
    end;
    
    % for plot result
    plot_point(iter, :) = point;
    
    hessian_mat = double(f_hessian(point(1), point(2)));
    gradient_mat = double(f_gradient(point(1), point(2)))';
    
    % check Hessian matrix is positive definite
    [col, eig_diagnol] = eig(double(hessian_mat)); % compute eigenvalue

    % if all eigenvalue > 0 
    if (isempty(find(diag(eig_diagnol) <= 0)) == 1)
        hessian_gradient = (inv(hessian_mat) * gradient_mat')';
        point = point - hessian_gradient; % Newton's method update
    else
        % inexact line search for the given search direction (-gradient)
        step_size = 5 * rand(1); % step_size initialization
        step_size = inexact_search(f, point, step_size, gradient_mat, -gradient_mat, max_iter);
        
        hessian_mat = eye(size(hessian_mat, 1), size(hessian_mat, 2));
        hessian_gradient = (inv(hessian_mat) * gradient_mat')';
        point = point - (step_size * hessian_gradient); % Gradient descent update
    end;
    
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
title('Newton''s Method')