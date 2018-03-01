% 2017 Fall Numerical Optimization Homework #1
% 2017. 09. 25
% 20161216 HAN SANGJUN

%% Problem 3 - find local minima ((1/3)*x^3 - 2*x^2 + 3*x + 3)
clc;
clear;
close all;

syms x;
f = symfun((1/3)*x^3 - 2*x^2 + 3*x + 3, x);

% first derivative
fx = diff(f, x);

% ======================== Bisection method ========================
% automatically generate init where f(a)f(b) < 0
% but I need local minima, starting strictly with f(a) < 0, f(b) > 0, a < b
init_range = 100; % init range where to pick up between [-100 100]
while 1
    init = -init_range + (init_range + init_range) * rand(1, 2);
    if (fx(init(1)) < 0) && (fx(init(2)) > 0) && (init(1) < init(2))
        break;
    end;
end;
epsilon_0 = 0.005; % terminate condition when almost f(x) = 0
epsilon_ab = 0.001; % terminate condition when b - a < epsilon
[opt_x, opt_y, time] = bisection(fx, init, epsilon_0, epsilon_ab);
local_min = double(f(opt_x));
fprintf('3. Bisection - It takes %fsec to generate local minima %f at %f, when derivative of f(x) = %f\n', time, local_min, opt_x, opt_y);

% ======================== Newton's method ========================
% second derivative
fxx = diff(fx, x);

% automatically generate init
% but I need local minima, starting strictly with f' > 0
init_range = 100; % init range where to pick up between [-100 100]
while 1
    init = -init_range + (init_range + init_range) * rand(1);
    if (fx(init) > 0 && fxx(init) > 0)
        break;
    end;
end;
epsilon_0 = 0.005; % terminate condition when almost f(x) = 0
[opt_x, opt_y, time] = newton(fx, fxx, init, epsilon_0);
local_min = double(f(opt_x));
fprintf('3. Newton - It takes %fsec to generate local minima %f at %f, when derivative of f(x) = %f\n', time, local_min, opt_x, opt_y);

% ======================== Secant method ========================
% automatically generate init
% but I need local minima, starting strictly with a > 0, f(a) > 0, a < b
init_range = 100; % init range where to pick up between [-100 100]
while 1
    init = -init_range + (init_range + init_range) * rand(1, 2);

    if  (init(1) > 0) && (fx(init(1)) > 0) && (init(1) < init(2))
        break;
    end;
end;
epsilon_0 = 0.005; % terminate condition when almost f(x) = 0
[opt_x, opt_y, time] = secant(fx, init, epsilon_0);
local_min = double(f(opt_x));
fprintf('3. Secant - It takes %fsec to generate local minima %f at %f, when derivative of f(x) = %f\n', time, local_min, opt_x, opt_y);

% ======================== Regula falsi method ========================
% automatically generate init where f(a)f(b) < 0
% but I need local minima, starting strictly with f(a) < 0, f(b) > 0, a < b
init_range = 100; % init range where to pick up between [-100 100]
while 1
    init = -init_range + (init_range + init_range) * rand(1, 2);
    if (fx(init(1)) < 0) && (fx(init(2)) > 0) && (init(1) < init(2))
        break;
    end;
end;
epsilon_0 = 0.005; % terminate condition when almost f(x) = 0
[opt_x, opt_y, time] = regula(fx, init, epsilon_0);
local_min = double(f(opt_x));
fprintf('3. Regula - It takes %fsec to generate local minima %f at %f, when derivative of f(x) = %f\n', time, local_min, opt_x, opt_y);