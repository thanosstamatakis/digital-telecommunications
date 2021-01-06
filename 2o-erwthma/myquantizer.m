function [xq, centers] = myquantizer(x, N, min_val, max_val)
    % myquantizer - Description
    %
    % Syntax: [xq,centers] = myquantizer(x,N,min_val,max_val)
    %
    % Long description

    % Initializations
    qsteps = 2^N;
    delta = (max_val - min_val) / qsteps;
    parts = (min_val:delta:max_val)';
    centers = zeros(length(parts) - 1, 1);
    xq = zeros(length(parts) - 1, 1);

    % If values exceeds max(x)/min(x) take it to max(x)/min(x) 
    if (max_val > max(x))
        max_val = max(x);
    end

    if (min_val < min(x))
        min_val = min(x);
    end

    % Contain x to the [min_val,max_val] range
    for i = 1:length(x)
        if (x(i) > max_val)
            x(i) = max_val;
        end

        if (x(i) < min_val)
            x(i) = min_val;
        end
    end

    % Get all the centers 
    for i = 1:length(parts)-1
        centers(i) = parts(i) + (delta/2);
    end

    % Assign xq values to appropriate quantization zones
    for i = 1:length(x)
        for j = 2:length(parts)
            if (j < length(parts))
                if (x(i)>=parts(j-1) && x(i)<parts(j))
                    xq(i)=(j-1);
                    break;
                end
            else
                if (x(i)>=parts(j-1) && x(i)<=parts(j))
                    xq(i)=(j-1);
                end
            end
        end
    end

end