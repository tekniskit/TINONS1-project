function [ fit ] = GMMValidation(features, mixes )
    
    noClasses = size(mixes,2);
    
    for i = 1 : noClasses
        mix = mixes(i);
        fit(i,:) = gmmprob(mix, features);
    end
    
end

