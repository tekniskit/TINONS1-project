function [features] = extractFeatures(data, Fs)
    % Window size in seconds
    windowsize = 0.2; 

    % Number of cepstral coeffs (apart from 0'th coef)
    nc = 30;

    % Length of frame
    n = windowsize * Fs;

    % increment = hop size (in number of samples)
    inc = round(n/3);

    p = floor(3*log(Fs));

    features = melcepst(data(:,1), Fs, 'M0d', nc, p, n, inc);
end