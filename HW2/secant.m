%% Secant method

function [opt_x, opt_y, time] = secant(fx, next, epsilon_0)

tic;
while 1
    % terminate condition when almost f(x) = 0
    if (abs(fx(next(2))) < epsilon_0)
        opt_x = double(next(2));
        opt_y = double(fx(next(2)));
        time = toc;
        break;
    end;
    
    % update to find optimized point
    temp = next(2);
    next(2) = next(2) - fx(next(2)) * ((next(2) - next(1)) / ((fx(next(2)) - fx(next(1)))));
    next(1) = temp; % swap
end;