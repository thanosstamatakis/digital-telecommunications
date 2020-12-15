# Ερώτημα 1ο

1. ### Υλοποίηση συνάρτησης `myhuffmandict`, `myhuffmanenco`, `myhuffmandeco`.

   Για να τρέξετε τις συναρτήσεις κάντε τα παρακάτω:

   ```matlab
   % Initiate probabilities and symbols
   symbols = [{'a'} {'b'} {'c'} {'d'} {'e'} {'f'}];
   probabilities = [0.5000, 0.1250, 0.1250, 0.1250, 0.0625, 0.0625];

   % Get the huffman dict
   dict = myhuffmandict(symbols, probabilities);

   % Create a random stream of characters based on probabilities
   indices = randsrc(10,1,[1:numel(symbols); probabilities]);
   inputSig = [cell2mat(symbols(indices))];

   % Use huffman tree to encode the input signal
   code = myhuffmanenco(inputSig, dict);

   % Decompress received message using huffman tree
   sig = myhuffmandeco(code, dict);

   % Check if signals match
   isequal(inputSig,cell2mat(sig))
   ```

2. ### Για το δεύτερο ερώτημα μπορείτε απλά να τρέξετε το παρακάτω script:
   ```matlab
   % Run the second part of the first question
   run('q2.m');
   ```
   ### το οποίο δίνει τα ζητούμενα της εκφώνησης απευθείας.
