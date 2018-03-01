% 2017 Fall Numerical Optimization Homework #3
% 2017. 10. 11
% 20161216 HAN SANGJUN

%% Problem 5 - find local minima (3*x^4 + 4*x^3 - 96*x^2 + 240*x + 3)
clc;
clear;
close all;

% to confine the number of iterations for all optimization
max_iter = 10000;

% termination criterion (final length of interval < epsilon)
epsilon = 0.001;

% problem 5 function to be optimized
syms x;
f = symfun(3*x^4 + 4*x^3 - 96*x^2 + 240*x + 3, x);

% find initial interval [a, b]
range = 100; % x_init range where to pick up between [-100, 100]
[a, b, time] = initializer(f, range, max_iter);
fprintf('initialize - It takes %fsec to generate interval [%f, %f]\n', time, a, b);

% Fibonacci Search
[a_fibo, b_fibo, time, iter] = fibonacci_search(f, a, b, epsilon, max_iter);
fprintf('fibonacci - It takes %fsec to generate interval [%f, %f], the number of iter %d\n', time, a_fibo, b_fibo, iter);

% Golden Section Search
[a_gold, b_gold, time, iter] = golden_search(f, a, b, epsilon, max_iter);
fprintf('golden - It takes %fsec to generate interval [%f, %f], the number of iter %d\n', time, a_gold, b_gold, iter);