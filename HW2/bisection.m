%% Bisection method

function [opt_x, opt_y, time] = bisection(fx, init, epsilon_0, epsilon_ab)

tic; % time starts
while 1
    % get mid point
    mid = (init(1) + init(2)) / 2;
    
    % terminate condition when almost f(x) = 0 or b - a < epsilon
    if (abs(fx(mid)) < epsilon_0) || (init(2) - init(1) < epsilon_ab)
        opt_x = double(mid);
        opt_y = double(fx(mid));
        time = toc;
        break;
    end;
    
    % update to find optimized point
    if (fx(mid) * fx(init(1)) < 0) % getting narrow
        init(2) = mid;
    else
        init(1) = mid;
    end;
end;