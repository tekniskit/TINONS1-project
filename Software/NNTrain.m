function [ net ] = NNTrain(features, noClasses, hidden, alpha )

    % create network (object)
    net = mlp(size(features,2), hidden, noClasses, 'softmax', alpha);

    % Set up vector of options for the optimiser.
    options = zeros(1,18);
    options(14) = 1000;		% Number of training cycles. 

    N = size(features,1);
    Ni = N/noClasses;
    
    
    t = zeros(N, noClasses);
    for i=1:noClasses
        t(:,i) = [zeros((i-1)*Ni,1); ones(Ni,1); zeros(N-i*Ni,1)];
    end
   
    % Train using scaled conjugate gradients.
    net = netopt(net, options, features, t, 'scg');
    
end

