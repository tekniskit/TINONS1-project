function [training, test, Fs] = readDataFromFiles(files)
    training = [];
    test = [];
    Fs = [];

    for i=1:length(files)
        file = files(i);
        file = file{1};
        
        [ tr, te, F ] = readDataFromFile(file);
       
        if i > 1
            if length(tr) > length(training)
                tr = tr(1:length(training));
            else
                training = training(1:length(tr), :);
            end

            if length(te) > length(test)
                te = te(1:length(test));
            else
                test = test(1:length(te), :);
            end
        end
        
        training = [training tr];
        test = [test te];
        Fs = [Fs F];
    end
end