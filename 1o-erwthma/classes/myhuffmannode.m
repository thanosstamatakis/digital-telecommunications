classdef myhuffmannode
    properties
         character
         probability
         left_node
         right_node
    end
    methods
        % constructor
        function obj = myhuffmannode(c, p, l, r)
            if nargin == 4
                obj.character = c;
                obj.probability = p;
                obj.left_node = l;
                obj.right_node = r;
            end
            if nargin == 2
                obj.character = c;
                obj.probability = p;
            end
        end

        % Getter for character
        function ch = getCharacter(obj)
            ch = obj.character;
        end
        
        % Getter for left node
        function ln = getLeftNode(obj)
            ln = obj.left_node;
        end

        % Getter for left node
        function rn = getRightNode(obj)
            rn = obj.right_node;
        end
    end
end