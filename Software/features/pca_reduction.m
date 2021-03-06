function [ features, v ] = pca_reduction( features, noNewFeatures )
    [u,s, v] = svd(features);
    
    figure,
    d = (1/size(features,1))*diag(s).^2;
    plot(cumsum(d/sum(d)))
    
    v = v(:, 1:noNewFeatures);
    
    features = features*v;
end