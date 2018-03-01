% 2017 Fall Numerical Optimization Homework #6
% 2017. 11. 08
% 20161216 HAN SANGJUN

clc;
clear;
close all;
max_iter = 5000; % when reach to end of loop, evoke error      
epsilon = 0.001;  % for terminating condition

%% Problem 1 - find minima f(x, y) = 2*x^2 + 5*y^2
syms x y;
A = [2 0; 0 5];
X = symfun([x y], [x y]);
f = symfun(X * A * X.', [x y]);
f_residual = symfun(X * A, [x y]);

range = 10; % initial point range
% point = -range + (range + range) * rand(1, 2); % random initial point
point = [2.7, 9.0]; % random initial point

[min_point, output, time, iter] = linear_CG(f, f_residual, A, point, epsilon, max_iter);
fprintf('1. Linear CG - It takes %fsec to generate minimum [%f] in (x,y) = (%f,%f) for %d iter\n', time, output, min_point(1), min_point(2), iter);