function [res] = traversal(root, s, res)
    % traversal - Emulate huffmandict matlab function
    % Syntax: dict = traversal(<myhuffmannode>,'01', {})
    % Author: Athanasios Iasonas Stamatakis 1041889

    % If node is a leaf node return the result appended
    % to previous results
    if (isempty(root.left_node) && isempty(root.right_node) && isletter(root.character))
        res(end+1, :) = {[root.character],s};
        return;
    end
    
    % If any node has children
    % run the recursion
    res = traversal(root.left_node, [s, 1], res); 
    res = traversal(root.right_node, [s, 0], res);
end
