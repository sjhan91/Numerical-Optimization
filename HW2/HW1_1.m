% 2017 Fall Numerical Optimization Homework #1
% 2017. 09. 25
% 20161216 HAN SANGJUN

%% Problem 1 - find local minima (3*x^2 - 6*x + 7)
clc;
clear;
close all;

syms x;
f = symfun(3*x^2 - 6*x + 7, x);

% first derivative
fx = diff(f, x);

% ======================== Bisection method ========================
% automatically generate init where f(a)f(b) < 0, strictly a < b
init_range = 100; % init range where to pick up between [-100 100]
while 1
    init = -init_range + (init_range + init_range) * rand(1, 2);
    if (fx(init(1)) * fx(init(2)) < 0) && (init(1) < init(2))
        break;
    end;
end;
epsilon_0 = 0.005; % terminate condition when almost f(x) = 0
epsilon_ab = 0.001; % terminate condition when b - a < epsilon
[opt_x, opt_y, time] = bisection(fx, init, epsilon_0, epsilon_ab);
local_min = double(f(opt_x));
fprintf('1. Bisection - It takes %fsec to generate local minima %f at %f, when derivative of f(x) = %f\n', time, local_min, opt_x, opt_y);

% ======================== Newton's method ========================
% second derivative
fxx = diff(fx, x);

% automatically generate init
init_range = 100; % init range where to pick up between [-100 100]
init = -init_range + (init_range + init_range) * rand(1);
epsilon_0 = 0.005; % terminate condition when almost f(x) = 0
[opt_x, opt_y, time] = newton(fx, fxx, init, epsilon_0);
local_min = double(f(opt_x));
fprintf('1. Newton - It takes %fsec to generate local minima %f at %f, when derivative of f(x) = %f\n', time, local_min, opt_x, opt_y);

% ======================== Secant method ========================
% automatically generate init
init_range = 100; % init range where to pick up between [-100 100]
init = -init_range + (init_range + init_range) * rand(1, 2);
epsilon_0 = 0.005; % terminate condition when almost f(x) = 0
[opt_x, opt_y, time] = secant(fx, init, epsilon_0);
local_min = double(f(opt_x));
fprintf('1. Secant - It takes %fsec to generate local minima %f at %f, when derivative of f(x) = %f\n', time, local_min, opt_x, opt_y);

% ======================== Regula falsi method ========================
% automatically generate init where f(a)f(b) < 0
init_range = 100; % init range where to pick up between [-100 100]
while 1
    init = -init_range + (init_range + init_range) * rand(1, 2);
    if (fx(init(1)) * fx(init(2)) < 0)
        break;
    end;
end;
epsilon_0 = 0.005; % terminate condition when almost f(x) = 0
[opt_x, opt_y, time] = regula(fx, init, epsilon_0);
local_min = double(f(opt_x));
fprintf('1. Regula - It takes %fsec to generate local minima %f at %f, when derivative of f(x) = %f\n', time, local_min, opt_x, opt_y);