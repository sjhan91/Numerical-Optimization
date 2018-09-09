%% Inexact line search
function [step_size] = inexact_search(f, point, step_size, gradient, direction, max_iter)

reduction_rate = 0.5; % fixed reduction_rate
c = rand(1); % fixed c

for i=1:max_iter
    if (i == max_iter)
        % when reach to end of loop, evoke error
        error('Inexact line search failed!');
    end;
    
    left = point + (step_size * direction);
    % naive condition
    if(f(left(1), left(2)) <= f(point(1), point(2)) + (step_size * c * dot(gradient, direction)))
        break;
    end;
    
    % update step_size
    step_size = step_size * reduction_rate;
end;