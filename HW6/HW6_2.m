% 2017 Fall Numerical Optimization Homework #6
% 2017. 11. 08
% 20161216 HAN SANGJUN

clc;
clear;
close all;
max_iter = 5000; % when reach to end of loop, evoke error      
epsilon = 0.001;  % for terminating condition

%% Problem 2 - find minima f(x, y) = (1.5 - x + x*y)^2 + (2.25 - x + x*y^2)^2 + (2.625 - x + x*y^3)^2
syms x y a b;
f = symfun((1.5 - x + x*y)^2 + (2.25 - x + x*y^2)^2 + (2.625 - x + x*y^3)^2, [x y]);
f_approx = taylor(f, [x y], [a b], 'Order', 2); % taylor expansion of f for quadratic behavior
f_approx = symfun(f_approx, [x y a b]);
f_gradient = gradient(f_approx, [x y]);

range = 10; % initial point range
% point = -range + (range + range) * rand(1, 2); % random initial point
point = [-1 1];

[min_point, output, time, iter] = nonlinear_CG(f_approx, f, f_gradient, point, epsilon, max_iter);
fprintf('2. Nonlinear CG - It takes %fsec to generate minimum [%f] in (x,y) = (%f,%f) for %d iter\n', time, output, min_point(1), min_point(2), iter);