% Speaker Recognition Project
% Rune, Reimer & Nicolai

clear, close all, clc;

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
[features, v] = pca_reduction(features, 20);

weights = oneofkCodingTraining(features, noClasses);
net1 = ProbabilisticModelTraining(features,noClasses);
net2 = NNTrain(features,noClasses, 20, 0.1);




% Validation
testFeatures = extractFeatures(test, Fs)*v;
classSamples = size(testFeatures,1)/noClasses;
correctId = [ ones(3,classSamples) 2*ones(3,classSamples) 3*ones(3,classSamples)];


estimate1 = oneofkCodingValidation(testFeatures, weights);
estimate2 = ProbabilisticModelValidation(testFeatures,net1)'
estimate3 = NNValidation(testFeatures,net2)';

[val, id(1,:)] = max(estimate1);
[val, id(2,:)] = max(estimate2);
[val, id(3,:)] = max(estimate3);

difid = id - correctId;
for i = 1:3
    error(1,i) = ((length(find(difid(i,:)~= 0)))/size(difid,2))*100
    error(2,i) = ((length(find(difid(i,1:classSamples)~= 0)))/classSamples)*100
    error(3,i) = ((length(find(difid(i,classSamples+1:2*classSamples)~= 0)))/classSamples)*100
    error(4,i) = ((length(find(difid(i,2*classSamples+1:end)~= 0)))/classSamples)*100
end

%hist(id')

%estimate = ProbabilisticModelValidation(rune,net)';

%estimate = NNValidation(rune,net)';

% glud = testFeatures(1:length(testFeatures)*1/3, :);
% reimer = testFeatures(length(testFeatures)*1/3:length(testFeatures)*2/3, :);
% rune = testFeatures(length(testFeatures)*2/3:length(testFeatures), :);



% figure,hold on
% plot(estimate(1,:), 'r')
% plot(estimate(2,:), 'b')
% plot(estimate(3,:), 'g')
% 
% 
% figure, hist(id);

