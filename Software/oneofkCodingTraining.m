function [weights] = oneofkCodingTraining(training, Fs)
    
    features1 = extractFeatures(training(:,1), Fs(1));
    features2 = extractFeatures(training(:,2), Fs(2));
    features3 = extractFeatures(training(:,3), Fs(3));
    
    % Training Phase
    x = [features1; features2; features3];
    
    N1 = length(features1);
    N2 = length(features2);
    N3 = length(features3);
    
    t(:,1) = [ones(N1,1); zeros(N2+N3,1)];
    t(:,2) = [zeros(N1,1); ones(N2,1); zeros(N3,1)];
    t(:,3) = [zeros(N1+N2,1); ones(N3,1)];
    
    Z = [x ones(N1+N2+N3,1)];
    
    weights = inv(Z'*Z)*Z'*t;
end