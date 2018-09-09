%% Strong Wolfe condition
function [step_size] = strong_wolfe_search(f, f_gradient, point, step_size, gradient, direction, max_iter)

reduction_rate = 0.5; % fixed reduction_rate
c1 = 0.3;
c2 = 0.4;

for i=1:max_iter
    if (i == max_iter)
        % when reach to end of loop, evoke error
        error('Strong Wolfe search failed!');
    end;
    
    left = point + (step_size * direction);
    
    % strong Wolfe condition
    if(f(left(1), left(2), left(1), left(2)) <= f(point(1), point(2), point(1), point(2)) + (step_size * c1 * dot(gradient, direction)))
        if(abs(dot(f_gradient(left(1), left(2), left(1), left(2)), direction)) <= -c2 * dot(gradient, direction))
            break;
        end;
    end;
    
    % update step_size
    step_size = step_size * reduction_rate;
    
    % when stuck
    if(step_size <= 1E-6)
        break;
    end;
end;