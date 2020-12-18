% Initiate probabilities and symbols
symbols = [{'a'} {'b'} {'c'} {'d'} {'e'} {'f'} {'g'} {'h'} {'i'} {'j'} {'k'} {'l'} {'m'} {'n'} {'o'} {'p'} {'q'} {'r'} {'s'} {'t'} {'u'} {'v'} {'w'} {'x'} {'y'} {'z'}];
probabilities = [0.08167, 0.01492, 0.02783, 0.04253, 0.12702, 0.02228, 0.02015, 0.06094, 0.06966, 0.00153, 0.00772, 0.04025, 0.02406, 0.06749, 0.07507, 0.01929, 0.00095, 0.05987, 0.06327, 0.09056, 0.02758, 0.00978, 0.02360, 0.00150, 0.01974, 0.00074];

% Create a map for symbols and probabilities for easier data manipulation
probabilitymap = containers.Map(symbols,probabilities);

% Calculate all possible combinations for symbols for the second
% extention of the source
secondext_symbols = permn(cell2mat(symbols),2);

% Calculate all probabilities for the second extention of the source
secondext_prob = zeros(1, length(secondext_symbols));
for index = 1:length(secondext_symbols)
    secondext_prob(index) = probabilitymap(secondext_symbols(index, 1)) * probabilitymap(secondext_symbols(index, 2));
end

% Get the huffman dict
dict = myhuffmandict(cellstr(secondext_symbols)', secondext_prob);

% Create a random stream of characters based on secondext_prob (this is source A)
indices = randsrc(5000, 1, [1:numel(secondext_symbols)/2; secondext_prob]);
inputSig = cellstr(secondext_symbols(indices,:))';

% Use huffman tree to encode the input signal
code = myhuffmanenco(inputSig, dict);

% Decompress received message using huffman tree
sig = myhuffmandeco(code, dict);

% Check if signals match
disp('Comparison between initial stream from source A and decoded stream:');
isequal(inputSig, sig)
disp('Code length for source A with probabilities from wikipedia is:');
disp(length(code));