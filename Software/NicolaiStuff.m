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

weights = oneofkCodingTraining(features, noClasses);

testFeatures = extractFeatures(test, Fs)*v;


glud = testFeatures(1:length(testFeatures)*1/3, :);
reimer = testFeatures(length(testFeatures)*1/3:length(testFeatures)*2/3, :);
rune = testFeatures(length(testFeatures)*2/3:length(testFeatures), :);

estimate1 = oneofkCodingValidation(glud, weights);
estimate2 = oneofkCodingValidation(reimer, weights);
estimate3 = oneofkCodingValidation(rune, weights);


figure, hold on
plot(estimate1(1,:), 'r')
plot(estimate1(2,:), 'b')
plot(estimate1(3,:), 'g')

figure, hold on
plot(estimate2(1,:), 'r')
plot(estimate2(2,:), 'b')
plot(estimate2(3,:), 'g')

figure, hold on
plot(estimate3(1,:), 'r')
plot(estimate3(2,:), 'b')
plot(estimate3(3,:), 'g')




