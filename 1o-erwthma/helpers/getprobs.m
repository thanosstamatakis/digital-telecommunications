function [symbols, probabilities, frequencies] = getprobs(input_string)
    % getprobs - Get discrete symbols probabilities and frequencies for input string
    % Syntax: [symbols, probabilities, frequencies] = getprobs('asdasdasd')
    % Author: Athanasios Iasonas Stamatakis 1041889

    % Declarations
    symbols = unique(input_string, 'stable');
    frequencies = zeros(1, length(symbols));
    probabilities = zeros(1, length(symbols));

    % Calculate probabilities and frequencies
    for index = 1:length(symbols)
        frequencies(index) = length(strfind(input_string, symbols(index)));
        probabilities(index) = frequencies(index) / length(input_string);
    end
