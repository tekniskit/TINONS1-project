function [weights] = oneofkCodingTraining(features, noClasses)
    
    N = length(features);
    Ni = N/noClasses;
    
    t = zeros(N, noClasses);
    
    for i=1:noClasses
        t(:,i) = [zeros((i-1)*Ni,1); ones(Ni,1); zeros(N-i*Ni,1)];
    end
    
    Z = [features ones(N,1)];

    weights = inv(Z'*Z)*Z'*t;
end