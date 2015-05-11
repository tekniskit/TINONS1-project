function [features] = extractFeatures(data, Fs)
    % Window size in seconds
    windowsize = 0.3; 

    % Number of cepstral coeffs (apart from 0'th coef)
    nc = 60;

    features = [];
    
    for i=1:size(data,2)
        % Length of frame
        n = windowsize * Fs(i);

        % increment = hop size (in number of samples)
        inc = round(n/3);

        p = floor(3*log(Fs(i)));
        
        s = abs(spectrogram(data(:,i), n, n-inc,nc*5));
        mel = melcepst(data(:,i), Fs(i), 'M0d', nc, p, n, inc);
        features = [
            features;
            mel
        ];
    end
end