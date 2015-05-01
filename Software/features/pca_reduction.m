function [ features, v ] = pca_reduction( features, noNewFeatures )
    [v, score, d] = princomp(features);
    
    figure,
    plot(cumsum(d/sum(d)))
    
    v = v(:, 1:noNewFeatures);
    
    features = features*v;
end