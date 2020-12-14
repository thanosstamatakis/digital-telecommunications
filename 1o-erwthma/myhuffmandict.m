function [dict] = myhuffmandict(symbols, probabilities)
    addpath('classes');
    addpath('helpers');

    % myhuffmandict - Emulate huffmandict matlab function
    % Syntax: dict = myhuffmandict(char({'a'},[1])
    % Author: Athanasios Iasonas Stamatakis 1041889

    % Example input
    % symbols = char({'a'; 'b'; 'c'; 'd'; 'e'; 'f'});
    % probabilities = [5/100, 9/100, 12/100, 13/100, 16/100, 45/100];

    % Initialize queue and root node
    q = myqueue();
    root = myhuffmannode();

    % Initialize the nodes with their probabilities;
    for index = 1:length(symbols)
        symbol = symbols(index);
        probability = probabilities(index);

        q.push(myhuffmannode(symbol, probability));
    end

    % Keep popping elements lowest in probability
    % and add parent node for each pair of them
    while (q.size() > 1)
        x = q.head();
        q.pop();
        y = q.head();
        q.pop();

        f = myhuffmannode('-', (x.probability + y.probability), x, y);
        root = f;
        q.push(f);
    end

    % Traverse through the tree of nodes to
    % get the dictionary
    [dict] = traversal(root, [], {});
end
