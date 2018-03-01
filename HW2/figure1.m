clc;
clear;
close all;

syms x;
f = symfun(x^3 - 6*x^2 + 9*x + 7, x);
fx = diff(f, x);

l = -2:0.01:5;
plot(l, f(l))