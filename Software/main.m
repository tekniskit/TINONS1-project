% Speaker Recognition Project
% Rune, Reimer & Nicolai

clear, close all, clc;

addpath('libs/vb');
addpath('dataProcessing');

files = {'data/glud1.mp3', 'data/reimer1.mp3', 'data/rune1.mp3'};
[training, test, Fs] = readDataFromFiles(files);

weights = oneofkCodingTraining(training, Fs);

estimate = oneofkCodingValidation(test(:,3), Fs(3), weights);

hold on
plot(estimate(1,:), 'r')
plot(estimate(2,:), 'b')
plot(estimate(3,:), 'g')