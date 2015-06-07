function [ mysvm ] = SVMTraining( features, NoClasses )
%SVMTRANING Summary of this function goes here
%   Detailed explanation goes here
Ni = size(features,1)/NoClasses;
N = size(features,1);

% using Matlab function "svmtrain"
C = 1e4; % soft-margin parameter ("regularisation") - automatisk rescaled for imbalanced classes
mykernel = 'rbf'; % 'linear', 'quadratic',
my_sigma = 12; % kernel width
opts = statset();
for i = 1:NoClasses
    t_class = [2*ones((i-1)*Ni,1); ones(Ni,1); 2*ones(N-i*Ni,1)];
    mysvm{i} = svmtrain(features, t_class, 'boxconstraint', C, 'kernel_function', mykernel, 'rbf_sigma', my_sigma,'method', 'SMO', 'options', opts, 'showplot', 'true');
end
    
end

