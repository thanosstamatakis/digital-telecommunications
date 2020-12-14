classdef myqueue < handle

    properties (Access = private)
        elements
    end

    methods
        % constructor
        function obj = myqueue()
            obj.elements = [];
        end

        % Pushes elements to the queue by slicing into the position
        % that keeps the frequencies sorted
        function push(obj, item)

            if isempty(obj.elements)
                obj.elements = [obj.elements, item];
                return
            end

            if (length(obj.elements) == 1 && obj.elements(1).probability <= item.probability)
                obj.elements = [obj.elements, item];
                return
            end

            if (length(obj.elements) == 1 && obj.elements(1).probability > item.probability)
                obj.elements = [item, obj.elements];
                return
            end

            for index = 1:length(obj.elements)
                node = obj.elements(index);

                if (node.probability > item.probability)
                    obj.elements = [obj.elements(1:(index - 1)), item, obj.elements(index:length(obj.elements))];
                    return
                end

            end

            if (obj.elements(end).probability <= item.probability)
                obj.elements = [obj.elements, item];
            end

        end

        % Pops element from queue
        function pop(obj)

            if length(obj.elements) < 2
                obj.elements = [];
                return
            else
                obj.elements = obj.elements(2:end);
            end

        end

        % Returns the size of the queue
        function sz = size(obj)
            sz = length(obj.elements);
        end

        % Returns the head of the queue
        function hd = head(obj)
            hd = obj.elements(1);
        end

        % Returns the elements of the queue
        function el = getElements(obj)
            el = obj.elements;
        end

        % Prints the elements of the queue
        function printElements(obj)

            for index = 1:length(obj.elements)
                obj.elements(index)
            end

        end

    end

end
