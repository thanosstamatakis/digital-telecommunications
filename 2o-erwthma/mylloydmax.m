function [xq, centers, D] = mylloydmax(x, N, min_value, max_value)
    %mylloydmax - Description
    %
    % Syntax: [xq,centers,D] = mylloydmax(x, N, min_value, max_value)
    %
    % Long description

    signal_length = length(x);

    if (max_value > max(x))
        max_value = max(x);
    end

    if (min_value < min(x))
        min_value = min(x);
    end

    for i = 1:signal_length

        if (x(i) > max_value)
            x(i) = max_value;
        end

        if (x(i) < min_value)
            x(i) = min_value;
        end

    end

    % Calculate the centers as if it was uniform PCM
    % Number of levels.
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
    signalDistortion(1) = 1;
    % Initialize the quantization signal
    xq = zeros(length(x), 1);

    for k = 2:inf
        % Calculate quantization level limits for each iteration
        for i = 1:length(centers) - 1
            T(i + 1) = (centers(i) + centers(i + 1)) / 2;
        end

        % Calculate new quantization quantized signal centers for each iteration

        for i = 1:length(centers)
            centers(i) = mean(x((x >= T(i) & x <= T(i + 1))));
        end

        % Calculate quantized signal for each iteration
        for i = 1:length(centers)
            xq((x >= T(i) & x <= T(i + 1))) = centers(i);
        end

        % Calculate signal distortion and check if it's infinitesimal
        D(k) = mean((x - xq).^2);

        if abs(D(k) - D(k - 1)) < eps
            break;
        end

    end

    % Remove the first value of distortion that we added manually before beggining Lloyd - max
    D = D(2:k);

end
