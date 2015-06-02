function [ estimate ] = SVMValidation( mysvm, testfeatures, NoClasses)
%SVMVALIDATON Summary of this function goes here
%   Detailed explanation goes here
    for i = 1:NoClasses
    estimate(:,i) = svmclassify(mysvm{i}, testfeatures);  
    end
end

