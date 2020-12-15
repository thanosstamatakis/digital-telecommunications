% Initiate probabilities and symbols
symbols = [{'a'} {'b'} {'c'} {'d'} {'e'} {'f'} {'g'} {'h'} {'i'} {'j'} {'k'} {'l'} {'m'} {'n'} {'o'} {'p'} {'q'} {'r'} {'s'} {'t'} {'u'} {'v'} {'w'} {'x'} {'y'} {'z'}];
probabilities = [0.08167, 0.01492, 0.02783, 0.04253, 0.12702, 0.02228, 0.02015, 0.06094, 0.06966, 0.00153, 0.00772, 0.04025, 0.02406, 0.06749, 0.07507, 0.01929, 0.00095, 0.05987, 0.06327, 0.09056, 0.02758, 0.00978, 0.02360, 0.00150, 0.01974, 0.00074];

% Get the huffman dict
dict = myhuffmandict(symbols, probabilities);

% Create a random stream of characters based on probabilities (this is source A)
indices = randsrc(10000, 1, [1:numel(symbols); probabilities]);
inputSig = [cell2mat(symbols(indices))];

% Use huffman tree to encode the input signal
code = myhuffmanenco(inputSig, dict);

% Decompress received message using huffman tree
sig = myhuffmandeco(code, dict);

% Check if signals match
disp('Comparison between initial stream from source A and decoded stream:');
isequal(inputSig, cell2mat(sig))
disp('Code length for source A with probabilities from wikipedia is:');
disp(length(code));

% Initialize vars and open file
file_id = fopen(fullfile('assets', 'kwords.txt'));
next_line = fgetl(file_id);
fileStream = '';

% While there are lines read char[]
% Remove unwanted characters from file with regex
while ischar(next_line);
    fileStream = [fileStream, lower(regexprep(next_line, '[^a-zA-Z]', ''))];
    next_line = fgetl(file_id);
end

% Close file
fclose(file_id);

% Use huffman tree to encode the input signal from source B
code = myhuffmanenco(fileStream, dict);

% Decompress received message using huffman tree
sig = myhuffmandeco(code, dict);

% Check if signals match
disp('Comparison between initial stream from source B and decoded stream:');
isequal(fileStream, cell2mat(sig))
disp('Code length for source B with probabilities from wikipedia is:');
disp(length(code));
