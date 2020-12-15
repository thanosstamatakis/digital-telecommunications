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
[symbols, probabilities] = getprobs(fileStream);

% Create the huffman dictionary for source B with probabilities
% calculated from the kwords.txt file
dict = myhuffmandict(cellstr(symbols(:))', probabilities);

% Generate the huffman code from dictionary and input stream
code = myhuffmanenco(fileStream, dict);

% Decode the huffman code with the dictionary calculated above
out = myhuffmandeco(code, dict);

% Validate the results
disp('Comparison between initial stream from source B and decoded stream:');
disp(isequal(fileStream, cell2mat(out)));
disp('Code length for source B with probabilities from kwords.text file is:');
disp(length(code));
