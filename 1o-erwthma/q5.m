% Add helpers path for getprobs function
addpath('helpers');

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

% Get probabilities for all symbols from kwords.txt
[file_symbols, file_probabilities] = getprobs(fileStream);

% Initiate probabilities from wikipedia (alphabetic order)
wiki_probabilities = [0.08167, 0.01492, 0.02783, 0.04253, 0.12702, 0.02228, 0.02015, 0.06094, 0.06966, 0.00153, 0.00772, 0.04025, 0.02406, 0.06749, 0.07507, 0.01929, 0.00095, 0.05987, 0.06327, 0.09056, 0.02758, 0.00978, 0.02360, 0.00150, 0.01974, 0.00074];

% Create a map for symbols and probabilities for easier data manipulation
file_map = containers.Map(cellstr(file_symbols')', file_probabilities);

% Create a map for symbols and probabilities for easier data manipulation (unique function for sorting)
wiki_map = containers.Map(cellstr(unique(file_symbols)')', wiki_probabilities);

% Calculate all possible permutations for symbols for the second
% extention of the source
secsymbols = permn(file_symbols, 2);

% Calculate all probabilities for the second extention of the source
secprobfile = zeros(1, length(secsymbols));
secprobwiki = zeros(1, length(secsymbols));

for index = 1:length(secsymbols)
    secprobfile(index) = file_map(secsymbols(index, 1)) * file_map(secsymbols(index, 2));
    secprobwiki(index) = wiki_map(secsymbols(index, 1)) * wiki_map(secsymbols(index, 2));
end

% Transform second extension symbols to cell array
secsymbols = cellstr(secsymbols)';

% Transform fileStream to cell array paired symbols
fileStream = reshape(fileStream', 2, [])';
fileStream = cellstr(fileStream(:, :))';

% Run huffman functions for kwords.txt probabilities
file_dict = myhuffmandict(secsymbols, secprobfile);
file_code = myhuffmanenco(fileStream, file_dict);
file_sig = myhuffmandeco(file_code, file_dict);

% Display results
disp('File stream and decoding equality for calculated probabilities =');
disp(isequal(file_sig, fileStream));
disp('Code length for second extension of source B with probabilities from file is:');
disp(length(file_code));

% Run huffman functions for wikipidia probabilities
wiki_dict = myhuffmandict(secsymbols, secprobwiki);
wiki_code = myhuffmanenco(fileStream, wiki_dict);
wiki_sig = myhuffmandeco(wiki_code, wiki_dict);

% Display results
disp('File stream and decoding equality for wikipedia probabilities =');
disp(isequal(wiki_sig, fileStream));
disp('Code length for second extension of source B with probabilities from wikipedia is:');
disp(length(wiki_code));
