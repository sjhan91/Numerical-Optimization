%% Fibonacci Search
function [a, b, time, iter] = fibonacci_search(f, a, b, epsilon, max_iter)

% fibonacci initial point
fibonacci_array(1) = 1;
fibonacci_array(2) = 1;

% for plot initial point
l_init = a:0.01:b;
plot_index = 1;

% generate N which satisfies the final interval within epsilon
for i=3:max_iter
    % when reach to end of loop, evoke error
    if (i == max_iter)
        error('fibonacci - generating N failed!');
    end;
    
    % fibonacci array calculation
    fibonacci_array(i) = fibonacci_array(i-1) + fibonacci_array(i-2);
    
    % terminate condition
    if ((b - a) / fibonacci_array(i) <= epsilon)
        break;
    end;
end;

N = i;

% first iteration
x1 = a + ((fibonacci_array(N-2) / fibonacci_array(N)) * (b - a));
x2 = b - ((fibonacci_array(N-2) / fibonacci_array(N)) * (b - a));

tic;
% from second iteration to last iteration
for iter=1:max_iter
    % when reach to end of loop, evoke error
    if (iter == max_iter)
        error('fibonacci - optimization failed!');
    end;
    
    % for saving plot value
    if(mod(N, 3) == 1)
        plot_a(plot_index) = a;
        plot_b(plot_index) = b;
        plot_index = plot_index + 1;
    end;
    
    N = N - 1;
    
    if (f(x1) == f(x2) && (x1 ~= x2))
        a = x1;
        b = x2;
        break;
    elseif (f(x1) > f(x2))
        a = x1; % new interval [a, b]
        x1 = x2; % reusable
        if((N - 2) == 0)
            break;
        end;
        % start new iteration N - 1
        x2 = b - ((fibonacci_array(N-2) / fibonacci_array(N)) * (b - a));
    else
        b = x2; % new interval [a, b]
        x2 = x1; % reusable
        if((N - 2) == 0)
            break;
        end;
        % start new iteration N - 1
        x1 = a + ((fibonacci_array(N-2) / fibonacci_array(N)) * (b - a));
    end;
end;

time = toc;

%% for plot result
figure;
plot(l_init, f(l_init), 'b', 'LineWidth', 1.8);
hold on;
scatter(l_init(1), f(l_init(1)), 170, 'filled', 'y');
hold on;
scatter(l_init(end), f(l_init(end)), 170, 'filled', 'y');
hold on;

for i=1:plot_index-1
    random_color = rand(1, 3);
    scatter(plot_a(i), f(plot_a(i)), 70, 'filled', 'MarkerFaceColor', random_color);
    hold on;
    scatter(plot_b(i), f(plot_b(i)), 70, 'filled', 'MarkerFaceColor', random_color);
    hold on;
end;
hold off;
title('Fibonacci Search');
