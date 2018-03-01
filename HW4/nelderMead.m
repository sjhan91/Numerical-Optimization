%% Nelder and Mead Method
function [output, time, iter] = nelderMead(f, dim, range, epsilon, max_iter, alpha, beta, gamma)

tic;
plot_vertex = [];

% generate N+1 vertices in N-dimensional space
vertex = -range + (range + range) * rand(dim+1, dim);

for iter=1:max_iter
    % when reach to end of loop, evoke error
    if (iter == max_iter)
        error('max_iter - optimization failed!');
    end;
    
    % sort function evaluation along ascending order
    [sorted_value, sorted_index] = sort(double(f(vertex(:, 1), vertex(:, 2))));
    
    % keep vertex value for plot
    if(mod(iter, 2) == 0)
        plot_vertex = [plot_vertex; vertex];
    end;
    
    % termination condition - the average of vertex distance <= epsilon
    distance = mean(pdist(vertex, 'euclidean'));
    if (distance <= epsilon)
        break;
    end;
    
    % rearange vertex
    vertex = vertex(sorted_index, :);

    % mean of X1, ... ,Xn
    c = [];
    for i=1:dim
        c = [c, mean(vertex(1:end-1, i))];
    end;

    x_nplus1 = vertex(end, :);
    x_r = c + (alpha * (c - x_nplus1));
    f_r = double(f(x_r(1), x_r(2)));

    if (sorted_value(1) <= f_r) && (f_r <= sorted_value(end-1))
        % reflection step
        vertex(end, :) = x_r;
        continue;
    elseif (sorted_value(end-1) <= f_r)
        % contraction step
        if (f_r < sorted_value(end))
            x_c = c + (gamma *(x_r - c));
        else
            x_c = c + (gamma * (x_nplus1 - c));
        end;

        f_c = double(f(x_c(1), x_c(2)));

        if (f_c < min([f_r, f(x_nplus1(1), x_nplus1(2))]))
            x_nplus1 = x_c;
            vertex(end, :) = x_nplus1;
        else
            for i=2:dim+1
                vertex(i, :) = (vertex(i, :) + vertex(1, :)) / 2;
            end;
        end;
    elseif (f_r <= sorted_value(1))
        % expansion step
        x_e = c + (beta * (x_r - c));
        f_e = double(f(x_e(1), x_e(2)));
        
        if (f_e <= f_r)
            vertex(end, :) = x_e;
        else
            vertex(end, :) = x_r;
        end;
    end;
end;

output = sorted_value(1);
time = toc;

%% Plot Result
figure;
x = -10:0.2:10;
y = -10:0.2:10;
[X, Y] = meshgrid(x, y);
contour(X, Y, f(X, Y), 'ShowText', 'on');
hold on;

for i=1:size(plot_vertex, 1) / 3
    rand_color = rand(1, 3);
    line(plot_vertex(3*i-2:3*i , 1), plot_vertex(3*i-2:3*i, 2), f(plot_vertex(3*i-2:3*i , 1), plot_vertex(3*i-2:3*i, 2)), 'Color', rand_color, 'LineWidth', 1.5);
    hold on;
    line(plot_vertex([3*i, 3*i-2] , 1), plot_vertex([3*i, 3*i-2], 2), f(plot_vertex([3*i, 3*i-2] , 1), plot_vertex([3*i, 3*i-2], 2)), 'Color', rand_color, 'LineWidth', 1.5);
    hold on;
end;
title('Nelder and Mead');
