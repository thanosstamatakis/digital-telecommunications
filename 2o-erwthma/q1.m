% Calculate source A according to instructions
M = 10000;
t = (randn(M, 1) + j * randn(M, 1)) / sqrt(2);
sourceA = abs(t).^2;

% Plot sourceA
figure;
plot(sourceA);

% Declare number of bits for the quantization
for N = 4:2:6
    % Using myquantizer function and source A with
    % min = 0 and max = 4 and N=4 and N=6 bits
    [xq, centers] = myquantizer(sourceA, N, 0, 4);
    quantized = centers(xq);

    % Calculate SQNR (Signal quantization noise ratio)
    sqnr = mean(sourceA.^2) / mean((sourceA - centers(xq)).^2);
    % Convert to dBs.
    sqnr_db = 10 * log10(sqnr);

    % Plot each quantization
    figure;
    plot(centers(xq));

    disp(['For N=', num2str(N), ' bits']);
    disp(['SQNR for source A is ', num2str(sqnr), ' (', num2str(sqnr_db), ' dB', ').', ]);
end

% Count number of elements out of dynamic range
counter = 0;

for i = 1:length(sourceA)

    if (sourceA(i) < 0 || sourceA(i) > 4)
        counter = counter +1;
    end

end

% Calculate probability
probability = (counter / length(sourceA)) * 100;
disp(['The probability that data from source A is not in dynamic range is ', num2str(probability), '%.']);
