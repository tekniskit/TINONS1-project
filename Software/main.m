% Speaker Recognition Project
% Rune, Reimer & Nicolai

clear, close all, clc;

addpath('.\vb');

[ training1, test1, Fs1 ] = readDataFromFile('glud1.mp3');
[ training2, test2, Fs2 ] = readDataFromFile('Reimer1.mp3');
[ training3, test3, Fs3 ] = readDataFromFile('Rune1.mp3');

features1 = extractFeatures(training1, Fs1);
features2 = extractFeatures(training2, Fs2);
features3 = extractFeatures(training3, Fs3);