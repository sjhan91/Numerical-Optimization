% 2017 Fall Numerical Optimization Homework #1
% 2017. 09. 25
% 20161216 HAN SANGJUN

%% Problem 4 - find local minima ((3/4)*x^4 - 3*x^3 - (27/2)*x^2 - 15*x + 2)
clc;
clear;
close all;

syms x;
f = symfun((3/4)*x^4 - 3*x^3 - (27/2)*x^2 - 15*x + 2, x);

% first derivative
fx = diff(f, x);

% initialization
init = [3 8];
% ======================== Bisection method ========================
epsilon_0 = 0.005; % terminate condition when almost f(x) = 0
epsilon_ab = 0.001; % terminate condition when b - a < epsilon
[opt_x, opt_y, time] = bisection(fx, init, epsilon_0, epsilon_ab);
local_min = double(f(opt_x));
fprintf('4. Bisection - It takes %fsec to generate local minima %f at %f, when derivative of f(x) = %f\n', time, local_min, opt_x, opt_y);

% ======================== Newton's method ========================
% second derivative
fxx = diff(fx, x);
epsilon_0 = 0.005; % terminate condition when almost f(x) = 0
[opt_x, opt_y, time] = newton(fx, fxx, init(2), epsilon_0);
local_min = double(f(opt_x));
fprintf('4. Newton - It takes %fsec to generate local minima %f at %f, when derivative of f(x) = %f\n', time, local_min, opt_x, opt_y);

% ======================== Secant method ========================
% automatically generate init
epsilon_0 = 0.005; % terminate condition when almost f(x) = 0
[opt_x, opt_y, time] = secant(fx, init, epsilon_0);
local_min = double(f(opt_x));
fprintf('4. Secant - It takes %fsec to generate local minima %f at %f, when derivative of f(x) = %f\n', time, local_min, opt_x, opt_y);

% ======================== Regula falsi method ========================
% automatically generate init where f(a)f(b) < 0
epsilon_0 = 0.005; % terminate condition when almost f(x) = 0
[opt_x, opt_y, time] = regula(fx, init, epsilon_0);
local_min = double(f(opt_x));
fprintf('4. Regula - It takes %fsec to generate local minima %f at %f, when derivative of f(x) = %f\n', time, local_min, opt_x, opt_y);