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

J = [100*ones(60,5)]


for n = 1 : 60
    for rep = 1:3
    % Training
    features = extractFeatures(training, Fs);
    [features, v] = pca_reduction(features,n);
    
    mixes = GMMTraning(features, 3, noClasses);
    weights = oneofkCodingTraining(features, noClasses);
    net1 = ProbabilisticModelTraining(features,noClasses);
    net2 = NNTrain(features,noClasses, 50, 0.1);
    %mysvm = SVMTraining(features,noClasses);
    
    % Validation
    testFeatures = extractFeatures(test, Fs)*v;
    classSamples = size(testFeatures,1)/noClasses;
    correctId = [ ones(5,classSamples) 2*ones(5,classSamples) 3*ones(5,classSamples)];

    estimate1 = oneofkCodingValidation(testFeatures, weights);
    estimate2 = ProbabilisticModelValidation(testFeatures,net1)';
    estimate3 = GMMValidation(testFeatures, mixes);
    estimate4 = NNValidation(testFeatures,net2)';
    %estimate5 = SVMValidation(mysvm,testFeatures,noClasses);
    estimate5 = ones(1,length(estimate4));

    [val, id(1,:)] = max(estimate1);
    [val, id(2,:)] = max(estimate2);
    [val, id(3,:)] = max(estimate3);
    [val, id(4,:)] = max(estimate4);
    [val, id(5,:)] = min(estimate5);
    
    est{1} = estimate1;
    est{2} = estimate2;
    est{3} = estimate3;
    est{4} = estimate4;
    est{5} = estimate5;
    
    
    difid = id - correctId;
    for i = 1:5
        error(1,i) = ((length(find(difid(i,:)~= 0)))/size(difid,2))*100;
        error(2,i) = ((length(find(difid(i,1:classSamples)~= 0)))/classSamples)*100;
        error(3,i) = ((length(find(difid(i,classSamples+1:2*classSamples)~= 0)))/classSamples)*100;
        error(4,i) = ((length(find(difid(i,2*classSamples+1:end)~= 0)))/classSamples)*100;
    end

    for g = 1:5
        if J(n,g) > error(1,g)
           J(n,g) =  error(1,g);
        end 
    end
    
    end
    J
end



