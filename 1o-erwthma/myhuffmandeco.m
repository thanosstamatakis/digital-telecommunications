function message = myhuffmandeco(code, dict)
    % myhuffmandeco - Emulate huffmandeco matlab function
    % Syntax: code = myhuffmandeco(code, dict)
    % Author: Athanasios Iasonas Stamatakis 1041889

    message = {};
    tree = [];

    % Break down dict to symbols and representing codes
    symbols = dict(:,1);
    codes = dict(:,2);
    codetosymbols = cell(1, length(codes));
    for index = 1:length(symbols)
        symbolcode = cell2mat(codes(index));
        codetosymbols(index) = mat2cell(num2str(symbolcode(:))',1);
    end

    % Create a hash map from codes (converted to char arrays) to symbols
    charcodemap = containers.Map(codetosymbols, symbols);

    % Itterate through code and add character to
    % message when reaching a leaf
    previousindex = 1;
    for i = 1:length(code)

        if (isKey(charcodemap,num2str(code(previousindex:i)')'))
            message{end+1} = charcodemap(num2str(code(previousindex:i)')');
            previousindex=i+1;
        end


    end

end
