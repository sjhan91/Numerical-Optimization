% 2017 Fall Numerical Optimization Homework #5
% 2017. 11. 01
% 20161216 HAN SANGJUN

clc;
clear;
close all;
max_iter = 5000; % when reach to end of loop, evoke error
epsilon = 0.001;  % for terminating condition

%% Problem 3 - find minima f(x, y) = 100 * (y - x^2)^2 + 3 * (1 - x)^2
syms x y;
f = symfun(100 * (y - x^2)^2 + 3 * (1 - x)^2, [x y]);
f_gradient = gradient(f);
f_hessian = hessian(f, [x y]);

% point = [-1 1]; % initial point
% point = [0.5 1.5]; % near global minimun
point = -10 + (10 + 10) * rand(1, 2); % random initial point

[min_point, output, time, iter] = gradient_descent(f, f_gradient, point, epsilon, max_iter);
fprintf('1. Gradient Descent - It takes %fsec to generate minimum [%f] in (x,y) = (%f,%f) for %d iter\n', time, output, min_point(1), min_point(2), iter);

[min_point, output, time, iter] = newton_method(f, f_gradient, f_hessian, point, epsilon, max_iter);
fprintf('2. Newton''s Method - It takes %fsec to generate minimum [%f] in (x,y) = (%f,%f) for %d iter\n', time, output, min_point(1), min_point(2), iter);

[min_point, output, time, iter] = quasi_newton_sr1_method(f, f_gradient, point, epsilon, max_iter);
fprintf('3. Quasi Newton''s SR1 Method - It takes %fsec to generate minimum [%f] in (x,y) = (%f,%f) for %d iter\n', time, output, min_point(1), min_point(2), iter);

[min_point, output, time, iter] = quasi_newton_bfgs_method(f, f_gradient, point, epsilon, max_iter);
fprintf('4. Quasi Newton''s BFGS Method - It takes %fsec to generate minimum [%f] in (x,y) = (%f,%f) for %d iter\n', time, output, min_point(1), min_point(2), iter);