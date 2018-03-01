%% Newton's method

function [opt_x, opt_y, time] = newton(fx, fxx, next, epsilon_0)

tic;
while 1
    % terminate condition when almost f(x) = 0
    if (abs(fx(next)) < epsilon_0)
        opt_x = double(next);
        opt_y = double(fx(next));
        time = toc;
        break;
    end;
    
    % update to find optimized point
    next = next - (fx(next) / fxx(next));
end;