function [ estimate ] = SVMValidation( mysvm, testfeatures, NoClasses)
%SVMVALIDATON Summary of this function goes here
%   Detailed explanation goes here
    for i = 1:NoClasses
        estimate(i,:) = svmclassify(mysvm{i}, testfeatures)';  
    end
    
    for i = 1:length(estimate)
        if(sum(estimate(:,i) ==1) >1)
            estimate(:,i) = 2*ones(NoClasses,1);
        end
    end
    
end

