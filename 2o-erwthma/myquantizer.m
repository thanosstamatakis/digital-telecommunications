function [xq, centers, counts, sums, zones] = myquantizer(x, N, min, max)
    % myquantizer - Description
    %
    % Syntax: [xq,centers] = myquantizer(x,N,min,max)
    %
    % Long description

    % [x, Fs] = audioread('assets/speech.wav');
    %   min = min(x);
    % max = max(x);
    % N = 8;

    qsteps = 2^N;
    delta = (max - min) / qsteps;
    parts = (min:delta:max)';
    numbers = sort(x);

    zones = zeros(length(parts) - 1, 2);
    counts = zeros(length(parts) - 1, 1);
    sums = zeros(length(parts) - 1, 1);

    for i = 1:length(parts) - 1
        zones(i, :) = [parts(i), parts(i + 1)];
    end

    zoneindex = 1;
    for i = 1:length(numbers)
        if(numbers(i) >= zones(zoneindex,1) && numbers(i) < zones(zoneindex,2))
            sums(zoneindex) = sums(zoneindex) + numbers(i);
            counts(zoneindex) = counts(zoneindex) + 1;
        else
            while ~(numbers(i) >= zones(zoneindex,1) && numbers(i) < zones(zoneindex,2))
                if isequal(zoneindex,length(zones))  
                    break;
                end
                zoneindex = zoneindex + 1;
            end
            sums(zoneindex) = sums(zoneindex) + numbers(i);
            counts(zoneindex) = counts(zoneindex) + 1;
        end
    end

    centers = zeros(length(parts) - 1, 1);

    for i = 1:length(sums)
        if ~isequal(counts(i),0)
            centers(i) = sums(i)/counts(i);
        end
    end

    xq = zeros(length(x),1);

    for i = 1:length(x)
        for j = 1:length(zones)
            if (x(i)<zones(j,2))
                xq(i) = centers(j);
                break;
            end
        end
    end
end