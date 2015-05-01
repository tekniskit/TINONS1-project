% Speaker Recognition Project
% Rune, Reimer & Nicolai

clear, close all, clc;

addpath('libs/vb');
addpath('parseFiles');
addpath('features');
addpath('D:\MatlabLibs\prtools');


files = {'data/glud1.mp3', 'data/reimer1.mp3', 'data/rune1.mp3'};
[training, test, Fs] = readDataFromFiles(files);

noClasses = length(files);

% Training
features = extractFeatures(training, Fs);
[features, v] = pca_reduction(features, 10);
weights = oneofkCodingTraining(features, noClasses);


% Validation
testFeatures = extractFeatures(test, Fs) * v;

glud = testFeatures(1:length(testFeatures)*1/3, :);
reimer = testFeatures(length(testFeatures)*1/3:length(testFeatures)*2/3, :);
rune = testFeatures(length(testFeatures)*2/3:length(testFeatures), :);

estimate = oneofkCodingValidation(rune, weights);

figure,hold on
plot(estimate(1,:), 'r')
plot(estimate(2,:), 'b')
plot(estimate(3,:), 'g')

[val, id] = max(estimate);
figure, hist(id);
