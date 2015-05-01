function [estimate] = oneofkCodingValidation(features, weights)

    N = length(features);
   
    Z = [features ones(N,1)];

    estimate = weights' * Z';
end