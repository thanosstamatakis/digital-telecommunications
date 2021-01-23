% Read file 'speech.wav' respecting paths for any os
[sourceB, Fs] = audioread(fullfile('assets', 'speech.wav'));

% Wait for adding multiple plots
hold on

% Get the sqnr change as a vector
sqnr_db_lloydmax = [];

for N = 2:2:6
    [xq, centers, sqnr, sqnr_db] = mylloydmax(sourceB, N, -1, 1);
    plot(sqnr_db)
    sqnr_db_lloydmax = [sqnr_db_lloydmax, sqnr_db(end)];
end

legend({'N=2', 'N=4', 'N=6'}, 'Location', 'northeast', 'FontSize', 18);
hold off

% Get the sqnr change as a vector
sqnr_db_uniform = [];

for N = 2:2:6
    [xq, centers] = myquantizer(sourceB, N, -1, 1);
    sqnr_db_uniform = [sqnr_db_uniform, 10 * log10(mean(sourceB.^2) / mean((sourceB - centers(xq)).^2))];
end

for index = 1:3
    disp(['SQNRs for ', num2str(2 * index), ' bits:'])
    disp(['For lloyd-max: ', num2str(sqnr_db_lloydmax(index)), 'dB.']);
    disp(['For uniform: ', num2str(sqnr_db_uniform(index)), 'dB.']);
end

for N = 2:2:6
    [xq, centers] = myquantizer(sourceB, N, -1, 1);
    analysis = tabulate(xq);
    probabilities = analysis(:,3);
    probabilities = probabilities ./ 100;
    for index = 1:length(probabilities)
        if (isequal(probabilities(index),0))
            probabilities(index) = eps;
        end
    end
    entropy = -sum(probabilities .* log2(probabilities));
    disp(['Entropy for ',num2str(N),' bits is: ',num2str(entropy)]);
    figure;
    bar(probabilities);
end
