function [estimate] = oneofkCodingValidation(test, Fs, weights)
    
    addpath('D:\MatlabLibs\prtools');

    features = extractFeatures(test, Fs);
    
    N = length(features);
   
    Z = [features ones(N,1)];

    estimate = weights' * Z';
end