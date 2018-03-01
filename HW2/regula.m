%% Regula falsi method

function [opt_x, opt_y, time] = regula(fx, next, epsilon_0)

tic;
while 1
    % update to find optimized point
    mid = next(2) - fx(next(2)) * ((next(2) - next(1)) / ((fx(next(2)) - fx(next(1)))));

    % terminate condition when almost f(x) = 0
    if (abs(fx(mid)) < epsilon_0)
        opt_x = double(mid);
        opt_y = double(fx(mid));
        time = toc;
        break;
    end;

    % update to find optimized point
    if (fx(mid) * fx(next(1)) < 0) % getting narrow
        next(2) = mid;
    else
        next(1) = mid;
    end;
end;