function [ fit ] = HMMValidation( net , features )
%HMMVALIDATION Summary of this function goes here
%   Detailed explanation goes here

    for i = 1: length(net)
        [LL, prior, transmat, mu, sigma, mixmat] = net{i};
        
        
        
        
    end 
    
    [B, B2] = mixgauss_prob(data, mu, Sigma, mixmat, unit_norm)

    
    obslik = multinomial_prob(data{13}, obsmat2);
    [alpha, beta, gamma, ll] = fwdback(prior2, transmat2, obslik, 'fwd_only', 1); % eg. compare ll with model with different pi, A, phi

    % find most probable hidden path to have generated seq. 13..
    obslik = multinomial_prob(data{11}, obsmat2);
    path = viterbi_path(prior2, transmat2, obslik);
    subplot(211), stem(path) % estimated hidden path
    subplot(212), stem(hidden_data{11}), axis tight % true path (since generated data..)


    
    
    
end

