function [fit] = ProbabilisticModelValidation(features, net)

    fit = glmfwd(net, features);
    
end
