function [xq, centers, D, sqnr, sqnr_db] = mylloydmax(x, N, min_value, max_value)
    %mylloydmax - Description
    %
    % Syntax: [xq,centers,D, sqnr, sqnr_db] = mylloydmax(x, N, min_value, max_value)
    %
    % Long description

    signal_length = length(x);

    % If values exceeds max(x)/min(x) take it to max(x)/min(x) 
    % if (max_value > max(x))
    %     max_value = max(x);
    % end

    % if (min_value < min(x))
    %     min_value = min(x);
    % end

    % Contain signal between min max values
    for i = 1:signal_length

        if (x(i) > max_value)
            x(i) = max_value;
        end

        if (x(i) < min_value)
            x(i) = min_value;
        end

    end

    % Initialize as uniform PCM
    levels = 2^N;
    level_length = (max_value - min_value) / levels;
    centers = zeros(levels, 1);

    % Iterate throuh max - min with a step of level length and this will result in the uniform centers
    current_center = 0;

    for i = min_value:level_length:max_value - level_length
        current_center = current_center + 1;
        centers(current_center) = i + level_length / 2;
    end

    % Lloyd max iterations: we set the limits of the quantized signal and the 1st distortion value
    % before beggining itterations
    T = zeros(levels + 1, 1);
    T(1) = min_value;
    T(levels + 1) = max_value;

    % Initialize the quantization signal
    xq = zeros(length(x), 1);

    % Supress for loop warning temporarily
    warning('off', 'MATLAB:warn_truncate_for_loop_index');

    for k = 2:inf
        % Calculate quantization level limits for each iteration
        for i = 1:length(centers) - 1
            T(i + 1) = (centers(i) + centers(i + 1)) / 2;
        end

        % Calculate new quantization quantized signal centers for each iteration

        for i = 1:length(centers)
            if (isnan(mean(x((x >= T(i) & x <= T(i + 1))))))
                centers(i) = T(i+1);
            else
                centers(i) = mean(x((x >= T(i) & x <= T(i + 1))));
            end
        end

        % Calculate quantized signal for each iteration
        for i = 1:length(centers)
            xq((x >= T(i) & x <= T(i + 1))) = i;
        end

        % Calculate signal distortion and check if it's infinitesimal
        D(k) = mean((x - centers(xq)).^2);

        % Calculate SQNR (Signal quantization noise ratio)
        sqnr(k) = mean(x.^2)/mean((x-centers(xq)).^2);
        sqnr_db(k) = 10 * log10(sqnr(k));

        if abs(D(k) - D(k - 1)) < 1e-16
            break;
        end

    end

    % Re-enable for loop warning
    warning('on', 'MATLAB:warn_truncate_for_loop_index');

    % Remove the arbitrary initial distortion value
    D = D(2:k);
    sqnr = sqnr(2:k);
    sqnr_db = sqnr_db(2:k);

    % Log the number of iterations
    disp(['Finished after ', num2str(length(D)), ' iterations.']);

end
