% Speaker Recognition Project
% Rune, Reimer & Nicolai

addpath('.\vb')

clear all
close all
clc

trainingvar = 0.7; % How much data should be used for training (70%)

[ data1, Fs1 ] = audioread('glud1.mp3');
[ data2, Fs2 ] = audioread('Reimer1.mp3');
[ data3, Fs3 ] = audioread('Rune1.mp3');

data1 = data1(:,1);
data2 = data2(:,1);
data3 = data3(:,1);
datacomp = data1;

%     y = y - mean(y);    %REMOVAL OF MEAN OF SOUND INPUT
data1 = data1 - mean(data1);
data2 = data2 - mean(data2);
data3 = data3 - mean(data3);

%     y = sqrt(length(y)) * y / norm(y); % WHITENING OF SOUND INPUT 
data1 = sqrt(length(data1)) * data1 / norm(data1);
data2 = sqrt(length(data2)) * data2 / norm(data2);
data3 = sqrt(length(data3)) * data3 / norm(data3);

%     y = y + eps;    % To avoid numerical probs

data1 = data1 + eps;
data2 = data2 + eps;
data3 = data3 + eps; 

training = [];

trainingcut = size(data2,1)*trainingvar;

training = [ data1(1:trainingcut,1) data2(1:trainingcut,1) data3(1:trainingcut,1) ];

windowsize = 0.150; % (in seconds)
nc = 12; % no. of cepstral coeffs (apart from 0'th coef)
n = windowsize*Fs1; % length of frame
inc = round(n/3); % increment = hop size (in number of samples)
p = floor(3*log(Fs1));

%voicebox_mfcc_dmfcc = melcepst(training(:,1), Fs1, 'M0d',nc, p, n, inc);
traindata1 = melcepst(training(:,1), Fs1, 'M0d',nc, p, n, inc);
traindata2 = melcepst(training(:,2), Fs1, 'M0d',nc, p, n, inc);
traindata3 = melcepst(training(:,3), Fs1, 'M0d',nc, p, n, inc);

% Vi kan tilføje hvid støj for at billigt generere flere samples.
% Optage i nyt miljø
% "Cross talk"

