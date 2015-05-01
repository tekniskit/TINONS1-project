function [] = oneofkCodingValidation(test, Fs, weights)
    
    addpath('D:\MatlabLibs\prtools');

    features1 = extractFeatures(test(:,1), Fs(1));
    features2 = extractFeatures(test(:,2), Fs(2));
    features3 = extractFeatures(test(:,3), Fs(3));
    
    N = length(features1) + length(features2) + length(features3);
    
    x = [features1; features2; features3];
    Z = [x ones(N,1)];

    y_est = weights' * Z';
    [val, id] = max(y_est);
    t_est = id-1;
    
    confmat([zeros(N/3,1); ones(N/3,1); 2*ones(N/3,1)], t_est', 'disagreement')
end