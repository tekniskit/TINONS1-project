% Speaker Recognition Project
% Rune, Reimer & Nicolai

clear, close all, clc;

addpath('libs/vb');
addpath('libs/netlab');
addpath('parseFiles');
addpath('features');
%addpath('D:\MatlabLibs\prtools');


files = {'data/glud1.mp3', 'data/reimer1.mp3', 'data/rune1.mp3'};
[training, test, Fs] = readDataFromFiles(files);

noClasses = length(files);

% Training
features = extractFeatures(training, Fs);
[features, v] = pca_reduction(features, 40);

%net = ProbabilisticModelTraining(features,noClasses);
net = NNTrain(features,noClasses, 5, 0.1);

%weights = oneofkCodingTraining(features, noClasses);


% Validation
testFeatures = extractFeatures(test, Fs)*v;



glud = testFeatures(1:length(testFeatures)*1/3, :);
reimer = testFeatures(length(testFeatures)*1/3:length(testFeatures)*2/3, :);
rune = testFeatures(length(testFeatures)*2/3:length(testFeatures), :);

% estimate = oneofkCodingValidation(testFeatures, weights);

%estimate = ProbabilisticModelValidation(rune,net)';

estimate = NNValidation(rune,net)';

figure,hold on
plot(estimate(1,:), 'r')
plot(estimate(2,:), 'b')
plot(estimate(3,:), 'g')

[val, id] = max(estimate);
figure, hist(id);

