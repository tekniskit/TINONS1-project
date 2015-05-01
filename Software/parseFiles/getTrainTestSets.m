function [training, test] = getTrainTestSets(data)
    TrainingToTestRatio = 0.7;
    
    data = normalizeSound(data);
  
    splitIndex = round(size(data,1) * TrainingToTestRatio);

    training = data(1 : splitIndex);
    test = data(splitIndex+1 : end);
end