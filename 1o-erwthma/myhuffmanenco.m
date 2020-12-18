function code = myhuffmanenco(src, dict)
    % myhuffmanenco - Emulate huffmanenco matlab function
    % Syntax: code = myhuffmanenco(src, dict)
    % Author: Athanasios Iasonas Stamatakis 1041889
    code = [];

    for i = 1:length(src)

        for j = 1:length(dict)

            % if (src(i) == cell2mat(dict(j, 1)))
            if ~iscell(src)
                if isequal(src(i),cell2mat(dict(j, 1)))
                    code = [code(1:end), cell2mat(dict(j, 2))];
                end
            else
                if isequal(src(i),dict(j, 1))
                    code = [code(1:end), cell2mat(dict(j, 2))];
                end
        end

    end

end
