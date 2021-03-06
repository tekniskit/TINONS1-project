% Speaker Recognition Project
% Rune, Reimer & Nicolai

clear, close all, clc;
rmpath(genpath('libs'));

addpath('libs/vb');
addpath('libs/netlab');
addpath('parseFiles');
addpath('features');
addpath('libs/prtools');

if(exist('ProbabilisticModel.mat', 'file'))
    load('ProbabilisticModel.mat');
else 
    bestErrorProbabilisticModel = 100;
end

if(exist('GMM.mat', 'file'))
    load('GMM.mat');
else 
    bestErrorGMM = 100;
end

if(exist('NN.mat', 'file'))
    load('NN.mat');
else 
    bestErrorNN = 100;
end
    

files = {'data/glud1.mp3', 'data/reimer1.mp3', 'data/rune1.mp3'};
[training, test, Fs] = readDataFromFiles(files);
noClasses = length(files);

% Training
features = extractFeatures(training, Fs);
[features, v] = pca_reduction(features,3);


while(true)
    mixes = GMMTraning(features, randi([1 5],1,1), noClasses);
    weights = oneofkCodingTraining(features, noClasses);
    net1 = ProbabilisticModelTraining(features,noClasses);
    net2 = NNTrain(features,noClasses, randi([1 50],1,1), 0.1);
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

    
    error

    if(bestErrorProbabilisticModel> error(1,2))
        bestErrorProbabilisticModel = error(1,2);
        save('ProbabilisticModel.mat','net1','bestErrorProbabilisticModel');
    end

    if(bestErrorGMM> error(1,3))
        bestErrorGMM = error(1,3);
        save('GMM.mat','mixes','bestErrorGMM');
    end

    if(bestErrorNN> error(1,4))
        bestErrorNN = error(1,4);
        save('NN.mat','net2','bestErrorNN');
    end
    
    
end

hist(id')

%estimate = ProbabilisticModelValidation(rune,net)';

%estimate = NNValidation(rune,net)';

% glud = testFeatures(1:length(testFeatures)*1/3, :);
% reimer = testFeatures(length(testFeatures)*1/3:length(testFeatures)*2/3, :);
% rune = testFeatures(length(testFeatures)*2/3:length(testFeatures), :);

figure,hold on
plot(estimate3(1,:), 'r')
plot(estimate3(2,:), 'b')
plot(estimate3(3,:), 'g')
% 
% 
% figure, hist(id);

