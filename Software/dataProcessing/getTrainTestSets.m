function [training, test] = getTrainTestSets(data)
    TrainingToTestRatio = 0.7;

    % Remove mean of data
    data = data - mean(data);

    % Whitening of data
    data = sqrt(length(data)) * data / norm(data);

    % To avoid numerical problems
    data = data + eps;
  
    splitIndex = round(size(data,1) * TrainingToTestRatio);

    training = data(1 : splitIndex);
    test = data(splitIndex+1 : end);
end