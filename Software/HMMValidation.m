function [ fit ] = HMMValidation( net , features )
%HMMVALIDATION Summary of this function goes here
%   Detailed explanation goes here

    for i = 1: length(net)
        LL = net{i}{1}{1};
        prior = net{i}{2}{1};
        transmat = net{i}{3}{1};
        mu = net{i}{4}{1};
        sigma = net{i}{5}{1};
        mixmat = net{i}{6}{1};
        
        [obslik, B2] = mixgauss_prob(features', mu, sigma, mixmat);
        [alpha, beta, gamma, ll] = fwdback(prior, transmat, obslik, 'fwd_only', 1); % eg. compare ll with model with different pi, A, phi
        
        fit(i) = ll
    end 


    
    
end

