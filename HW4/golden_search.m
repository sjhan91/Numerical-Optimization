%% Golden Section Search
function [a, b, time, iter] = golden_search(f, a, b, epsilon, max_iter)

% golden ratio tau
tau = (-1 + sqrt(5)) / 2;

% for plot initial point
l_init = a:0.01:b;
plot_index = 1;

% generate N which satisfes the final interval withins epsilon
for i=1:max_iter
    % when reach to end of loop, evoke error
    if (i == max_iter)
        error('golden - generating N failed!');
    end;
    
    % terminate condition
    if ((b - a) * (tau^(i - 1)) <= epsilon)
        break;
    end;
end;

N = i;

% first iteration
x1 = a + ((1 - tau) * (b - a));
x2 = b - ((1 - tau) * (b - a));

tic;
% from second iteration to last iteration
for iter=1:max_iter
    % when reach to end of loop, evoke error
    if (iter == max_iter)
        error('golden - optimization failed!');
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
        if(N == 0)
            break;
        end;
        % start new iteration N - 1
        x2 = b - ((1 - tau) * (b - a));
    else
        b = x2; % new interval [a, b]
        x2 = x1; % reusable
        if(N == 0)
            break;
        end;
        % start new iteration N - 1
        x1 = a + ((1 - tau) * (b - a));
    end;
end;

time = toc;