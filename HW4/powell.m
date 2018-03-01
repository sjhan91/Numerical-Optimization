%% Powell's Method
function [output, time, iter] = powell(f, dim, N, range_powell, epsilon_powell, max_iter_powell)

tic;

% generate unit direction vector
u_raw = -range_powell + (range_powell + range_powell) * rand(N, dim);
u_denom = sqrt(sum(u_raw.^2, 2));
u = [];
for i=1:dim
    u = [u, (u_raw(:, i) ./ u_denom)];
end;

% initial point x_0
x_point(1, :) = -range_powell + (range_powell + range_powell) * rand(1, dim);
p(1, :) = x_point(1, :); % p_0

iter = 0;
plot_point = [];
syms r t;
while (iter <= max_iter_powell)
    % when reach to end of loop, evoke error
    if (iter == max_iter_powell)
        error('max_iter - optimization failed!');
    end;
    
    % find the step Rk minimizing f(P(k-1) + Rk * Uk)
    for k=1:N
        % function to be minimized 
        fr = symfun(f((p(k, 1) + r * u(k, 1)), (p(k, 2) + r * u(k, 2))), r);

        range = 100; % x_init range where to pick up between [-100, 100]
        [a, b, time] = initializer(fr, range_powell, max_iter_powell); % find unimodal initial interval [a, b]
        [a_gold, b_gold, time, iter_golden] = golden_search(fr, a, b, epsilon_powell, max_iter_powell); % Golden Section Search
        p(k+1, :) = p(k, :) + (((a_gold + b_gold) / 2) * u(k, :)); % update
    end;

    iter = iter + 1;
    
    % u(j) = u(j+1)
    for j=1:N-1
        u(j, :) = u(j+1, :);
    end;
    
    % new direction vector
    u(end, :) = p(end, :) - p(1, :);
    
    % find the step R minimizing f(P0 + R * UN)
    fr_n = symfun(f((p(1, 1) + t * u(end, 1)), (p(1, 2) + t * u(end, 2))), t);
    [a, b, time] = initializer(fr_n, range_powell, max_iter_powell); % find unimodal initial interval [a, b]
    [a_gold, b_gold, time, iter_golden] = golden_search(fr_n, a, b, epsilon_powell, max_iter_powell); % Golden Section Search
    x_point(iter+1, :) = p(1, :) + (((a_gold + b_gold) / 2) * u(end, :)); % update
    
    % termination condition
    distance = mean(pdist(x_point(end-1:end, :), 'euclidean'));
    if (double(f(x_point(end, 1), x_point(end, 2)) <= 0.05))
        break;
    end;
    
    p(1, :) = x_point(iter+1, :); % p_0
end;

% output
output = double(f(x_point(end, 1), x_point(end, 2)));
time = toc;

%% Plot Result
figure;
x = -20:0.2:20;
y = -20:0.2:20;
[X, Y] = meshgrid(x, y);
contour(X, Y, f(X, Y), 'ShowText', 'on');
hold on;

scatter(x_point(:, 1), x_point(:, 2), 'filled', 'r');
title('Powell');