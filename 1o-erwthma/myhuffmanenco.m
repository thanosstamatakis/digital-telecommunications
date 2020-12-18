function code = myhuffmanenco(src, dict)
    % myhuffmanenco - Emulate huffmanenco matlab function
    % Syntax: code = myhuffmanenco(src, dict)
    % Author: Athanasios Iasonas Stamatakis 1041889
    code = [];

    % Get symbols and codes from dict
    symbols = dict(:, 1)';
    codes = dict(:, 2)';

    % Create a hash map from codes (converted to char arrays) to symbols
    charcodemap = containers.Map(symbols, codes);

    if ~iscell(src)

        for i = 1:length(src)
            code = [code, charcodemap(src(i))];
        end

    else

        for i = 1:length(src)
            code = [code, charcodemap(cell2mat(src(i)))];
        end

    end

end
