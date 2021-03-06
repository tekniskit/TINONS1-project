function [ mix ] = GMMS(features, ncentres, iterations )
    cd('libs/netlab');
    dim = size(features,2) % dimension;
    covartype = 'full';%'spherical'; % covariance-matrix type.. 'spherical', 'diag' or 'full'

    mix = gmm(dim, ncentres, covartype);
    
    opts = foptions; % standard options
    opts(1) = 1; % show errors
    opts(3) = 0.001; % stop-criterion of EM-algorithm
    opts(5) = 0; % do not reset covariance matrix in case of small singular values.. (1=do reset..)
    opts(14) = iterations; % max number of iterations
    
    mix = gmminit(mix, features, opts); % initialize using Kmeans
    
    %[MIX, OPTIONS, ERRLOG] = GMMEM(MIX, X, OPTIONS)
    [mix, opts] = gmmem(mix, features, opts);
    
    if dim == 2 
        s1 = length(features)/3;
        % plot data
        xi=-50; xf=10; yi=-10; yf=15;
        
        figure,
        hold on
        inc=0.01;
        xrange = xi:inc:xf;
        yrange = yi:inc:yf;
        [X Y]=meshgrid(xrange, yrange);
        ygrid = gmmprob(mix, [X(:) Y(:)]);
        ygrid = reshape(ygrid,size(X));
        figure, imagesc(ygrid(end:-1:1, :)), colorbar
        figure, 
        hold on
        scatter(features(1:s1,1), features(1:s1,2), 'r')
        scatter(features(s1+1:2*s1,1), features(s1+1:2*s1,2), 'b')
        scatter(features(2*s1+1:end,1), features(2*s1+1:end,2), 'g')
        contour(xrange, yrange, ygrid,'k-')
    end 
    
    
    a = gmmactiv(mix,features)
    [val, id] = max(a');
    classSamples = size(features,1)/3;
    correctId = [ ones(1,classSamples) 2*ones(1,classSamples) 3*ones(1,classSamples)];
    
    difid = correctId - id;
    
    error(1,1) = ((length(find(difid(1,:)~= 0)))/size(difid,2))*100;
    error(2,1) = ((length(find(difid(1,1:classSamples)~= 0)))/classSamples)*100;
    error(3,1) = ((length(find(difid(1,classSamples+1:2*classSamples)~= 0)))/classSamples)*100;
    error(4,1) = ((length(find(difid(1,2*classSamples+1:end)~= 0)))/classSamples)*100;
    
    error
    
    cd('../..');
end

