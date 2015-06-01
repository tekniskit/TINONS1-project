function [ net ] = HMMTraining( features, HiddenLayers, iterations, NoClasses )
%HMMTRAINING Summary of this function goes here
%   Detailed explanation goes here
 
addpath('libs\HMM\HMMall\HMM')
addpath('libs\HMM\HMMall\KPMtools')
addpath('libs\HMM\HMMall\KPMstats')

 Ni = size(features,1)/NoClasses;

 for classCount = 1 : NoClasses
     
     for n = 1: Ni
         data{n} = features((classCount-1)*Ni+n,:)';
     end
     
     prior = [1 zeros(1, HiddenLayers-1)];
     transmat = rand(HiddenLayers,HiddenLayers);
     for i = 1: HiddenLayers
         for j = 1: i-1
             transmat(i,j) = 0; 
         end
         for j = i+2: HiddenLayers
             transmat(i,j) = 0; 
         end
     end 
     
     transmat = mk_stochastic(transmat);
     sigma = repmat(eye(size(features,2)), [1 1 HiddenLayers]);
     
     rindex = randperm(Ni);
     for i = 1 : HiddenLayers
         mu(:,i) = data{rindex(i)}
     end
     
     [LL, prior, transmat, mu, sigma, mixmat] = mhmm_em(data, prior, transmat, mu, sigma, [],'max_iter', iterations) 
     
     net{classCount} = {{LL}, {prior}, {transmat}, {mu}, {sigma}, {mixmat}};
     
 end 

 
end

