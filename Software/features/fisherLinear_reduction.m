function [ features, v ] = fisherLinear_reduction( features, noClasses )

    Ntot = length(features); 
    Ni = Ntot/noClasses;
    
    Sw = zeros(size(features,2));
    Sb = zeros(size(features,2));
    mu_tot = 0; 
    
    for i=1:noClasses,
        X = features(((i-1)*Ni)+1:(i*Ni), :); 
        mu = mean(X);
        N = size(X,1);
                
        
        Sw = Sw + (X - repmat(mu, N, 1))'*(X - repmat(mu, N, 1));
        mu_tot = mu_tot + N*mu;
    end
    
    mu_tot = mu_tot / Ntot;
    
    for i=1:noClasses,
        X = features(((i-1)*Ni)+1:(i*Ni), :); 
        mu = mean(X);
        N = size(X,1);      
        Sb = Sb + N*(mu - mu_tot)'*(mu - mu_tot);
    end
    
    % Analyze eigenvalues
    Swinv = inv(Sw + eye(size(Sw))); % could change reg.parameter.
    [v, score, d] = princomp(Swinv*Sb);
       
    v = v(:,1:noClasses-1);
    features = features*v;

end

