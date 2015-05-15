function [ mixes ] = GMMTraning(features, ncentres, noClasses )
    Ni = size(features,1)/noClasses;
    cd('libs/netlab');
    dim = size(features,2); % dimension;
    covartype = 'full';%'spherical'; % covariance-matrix type.. 'spherical', 'diag' or 'full'

    mix = gmm(dim, ncentres, covartype);
    
    opts = foptions; % standard options
    opts(3) = 0.001; % stop-criterion of EM-algorithm
    opts(5) = 1; % do not reset covariance matrix in case of small singular values.. (1=do reset..)
    opts(14) = 100; % max number of iterations
    
    for i = 1 : noClasses
        x = features((i-1)*Ni+1:(i)*Ni,:);
        mix = gmm(dim, ncentres, covartype);
        mix = gmminit(mix, x, opts); % initialize using Kmeans
        [mix, opts] = gmmem(mix, x, opts);
        mixes(i) = mix;
    end
    cd('../..');
end

