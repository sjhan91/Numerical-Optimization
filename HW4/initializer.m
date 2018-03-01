%% Initializer
function [a, b, time] = initializer(f, range, max_iter)

tic;
x_init = -range + (range + range) * rand(1); % initial point x0
d = rand(1); % step size d > 0, pick small initial d [0, 1]

% evaluate f_neg, f_cen, f_pos
f_neg = double(f(x_init - d));
f_cen = double(f(x_init));
f_pos = double(f(x_init + d));

% x_neg, x_init, x_pos
if (f_neg >= f_cen) && (f_cen >= f_pos)
    x_neg = x_init - d;
    x_pos = x_init + d;
elseif (f_pos >= f_cen) && (f_cen >= f_neg)
    x_neg = x_init + d;
    x_pos = x_init - d;
    d = -d;
elseif (f_neg >= f_cen) && (f_pos >= f_cen)
    a = x_init - d;
    b = x_init + d;
    time = toc;
    return;
end;

for i=1:max_iter
    if (i == max_iter)
        error('initialization failed!');
    end;
    
    % update: x(k+1) = x(k) + 2^k*d
    x_next = x_pos + ((2^i) * d);
    
    % terminate condition
    if (f(x_next) >= f(x_pos)) && (d > 0)
        a = x_init;
        b = x_next;
        break;
    elseif (f(x_next) >= f(x_pos)) && (d < 0)
        a = x_next;
        b = x_init;
        break;
    end;
    
    % shifting
    x_neg = x_init;
    x_init = x_pos;
    x_pos = x_next;
end;

time = toc;