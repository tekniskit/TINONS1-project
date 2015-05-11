% Speaker Recognition Project
% Rune, Reimer & Nicolai

clear, close all, clc;

addpath('libs/vb');
addpath('parseFiles');
addpath('features');
%addpath('D:\MatlabLibs\prtools');


files = {'data/glud1.mp3', 'data/reimer1.mp3', 'data/rune1.mp3'};
[training, test, Fs] = readDataFromFiles(files);

noClasses = length(files);

% Training
features = extractFeatures(training, Fs);
[features, v] = pca_reduction(features, 20);


glud = features(1:length(features)*1/3, :);
reimer = features(length(features)*1/3:length(features)*2/3, :);
rune = features(length(features)*2/3:length(features), :);


weights = oneofkCodingTraining(features, noClasses);


% Validation
testFeatures = extractFeatures(test, Fs)* v;

glud = testFeatures(1:length(testFeatures)*1/3, :);
reimer = testFeatures(length(testFeatures)*1/3:length(testFeatures)*2/3, :);
rune = testFeatures(length(testFeatures)*2/3:length(testFeatures), :);

estimate = oneofkCodingValidation(testFeatures, weights);

figure,hold on
plot(estimate(1,:), 'r')
plot(estimate(2,:), 'b')
plot(estimate(3,:), 'g')

%[val, id] = max(estimate);
%figure, hist(id);

