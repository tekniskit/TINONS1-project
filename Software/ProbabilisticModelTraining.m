function [net] = ProbabilisticModelTraining(features, noClasses)

    net = glm(size(features,2), noClasses, 'softmax');
    
    N = size(features,1);
    Ni = N/noClasses;
    
    t = zeros(N, noClasses);
    for i=1:noClasses
        t(:,i) = [zeros((i-1)*Ni,1); ones(Ni,1); zeros(N-i*Ni,1)];
    end
    
    options(5) = 1; % for softmax 
    options(14) = 1000; % max traning iterations 
    
    net = glmtrain(net, options, features, t);
    
end