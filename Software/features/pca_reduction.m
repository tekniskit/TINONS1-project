function [ features, v ] = pca_reduction( features, noNewFeatures )
    [s,d, v] = svd(features);
    
    %figure,
    %plot(cumsum(d/sum(d)))
    
    v = v(:, 1:noNewFeatures);
    
    features = features*v;
end