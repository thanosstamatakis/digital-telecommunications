function message = myhuffmandeco(code, dict)
    % myhuffmandeco - Emulate huffmandeco matlab function
    % Syntax: code = myhuffmandeco(code, dict)
    % Author: Athanasios Iasonas Stamatakis 1041889

    message = [];
    tree = [];

    % Itterate through code and add character to
    % message when reaching a leaf
    for i = 1:length(code)
        tree = [tree, code(i)];

        for j = 1:length(dict)

            if isequal(tree, cell2mat(dict(j, 2)))
                message = [message, dict(j, 1)];
                tree = [];
            end

        end

    end

end
