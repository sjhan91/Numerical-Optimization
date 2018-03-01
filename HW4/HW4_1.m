% 2017 Fall Numerical Optimization Homework #4
% 2017. 10. 18
% 20161216 HAN SANGJUN

clc;
clear;
close all;

%% Problem 1 - find minima f(x, y) = 2*x^2 + 5*y^2
alpha = 1;
beta = 2;
gamma = 0.5;

% problem 1
syms x y;
dim = 2;
f = symfun(2*x^2 + 5*y^2, [x y]);

range_nedler = 10; % generate N+1 vertices in N-dimensional space <= 10
epsilon_nedler = 0.05; % termination condition termination condition - the average of vertex distance <= epsilon
max_iter_nedler = 50000; % maximum iteration

% Nedler-Mead method
[output, time, iter] = nelderMead(f, dim, range_nedler, epsilon_nedler, max_iter_nedler, alpha, beta, gamma);
fprintf('1. Nelder and Mead - It takes %fsec to generate minimum [%f] for %d iter\n', time, output, iter);

N = 10; % the number of direction vector
range_powell = 10; % direction vector, starting point initialized in range of [-10, 10]
epsilon_powell = 0.05; % termination condition - the average of vertex distance <= epsilon
max_iter_powell = 50000; % maximum iteration

% Powell's method
[output, time, iter] = powell(f, dim, N, range_powell, epsilon_powell, max_iter_powell);
fprintf('2. Powell - It takes %fsec to generate minimum [%f] for %d iter\n', time, output, iter);