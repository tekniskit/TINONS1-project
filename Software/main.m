% Speaker Recognition Project
% Rune, Reimer & Nicolai

clear, close all, clc;

addpath('libs/vb');
addpath('dataProcessing');

[ training1, test1, Fs1 ] = readDataFromFile('data/glud1.mp3');
[ training2, test2, Fs2 ] = readDataFromFile('data/Reimer1.mp3');
[ training3, test3, Fs3 ] = readDataFromFile('data/Rune1.mp3');

features1 = extractFeatures(training1, Fs1);
features2 = extractFeatures(training2, Fs2);
features3 = extractFeatures(training3, Fs3);