% Speaker Recognition Project
% Rune, Reimer & Nicolai

clear, close all, clc;
rmpath(genpath('libs'));

addpath('libs/vb');
addpath('libs/netlab');
addpath('parseFiles');
addpath('features');
addpath('libs/prtools');

 
files = {'data/glud1.mp3', 'data/reimer1.mp3', 'data/rune1.mp3'};
[training, test, Fs] = readDataFromFiles(files);
noClasses = length(files);

% Training
features = extractFeatures(training, Fs);
[features, v] = pca_reduction(features, 40);
alpha = [1 0.1 0.05 0.01]
T = 70;
error = 100*ones(T,length(alpha));
for t = 1 : T
    disp('Next Iteration')
    for b = 1: length(alpha)
        for z = 1: 3
            net = NNTrain(features,noClasses, t, alpha(b));

            % Validation
            testFeatures = extractFeatures(test, Fs)*v;
            classSamples = size(testFeatures,1)/noClasses;
            correctId = [ ones(1,classSamples) 2*ones(1,classSamples) 3*ones(1,classSamples)];

            estimate3 = NNValidation(testFeatures,net)';
            [val, id] = max(estimate3);

            difid = id - correctId;
            e = ((length(find(difid(1,:)~= 0)))/size(difid,2))*100;
            if(e < error(t,b))
                error(t,b) = e;
            end
        end
    end
    error
end


