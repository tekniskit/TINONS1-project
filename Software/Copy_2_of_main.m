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

T = 3;
error = 100*ones(1,T);
for t = 1 : T
    disp('Next Iteration')
    for z = 1: 1
        net = NNTrain(features,noClasses, t, 0.1);

        % Validation
        testFeatures = extractFeatures(test, Fs)*v;
        classSamples = size(testFeatures,1)/noClasses;
        correctId = [ ones(1,classSamples) 2*ones(1,classSamples) 3*ones(1,classSamples)];

        estimate3 = NNValidation(testFeatures,net)';
        [val, id] = max(estimate3);

        difid = id - correctId;
        e = ((length(find(difid(1,:)~= 0)))/size(difid,2))*100;
        if(e < error(t))
            error(t) = e;
        end
    end
end

stem(error)

