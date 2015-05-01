function [training, test, Fs] = readDataFromFile(path)    
    [data, Fs] = audioread(path);

    % Channel 1
    [train1, test1] = getTrainTestSets(data(:,1));
    
    % Channel 2
    [train2, test2] = getTrainTestSets(data(:,2));

    training = [train1; train2];
    test = [test1; test2];
end