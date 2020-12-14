function [res] = traversal(root, s, res)
    % traversal - Traverse through the tree of myhuffmannodes
    % Syntax: dict = traversal(<myhuffmannode>,'01', {})
    % Author: Athanasios Iasonas Stamatakis 1041889

    % If node is a leaf node return the result appended
    % to previous results
    % if (isempty(root.left_node) && isempty(root.right_node) && isletter(root.character))

    if (isempty(root.left_node) && isempty(root.right_node) &&~strcmp(root.character, '-'))
        res(end + 1, :) = {[root.character], s};
        return;
    end

    % If any node has children
    % run the recursion
    if (~isempty(root.left_node))
        res = traversal(root.left_node, [s, 0], res);
    end

    if (~isempty(root.right_node))
        res = traversal(root.right_node, [s, 1], res);
    end

end
