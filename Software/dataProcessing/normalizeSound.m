function [data] = normalizeSound(data)
    % Remove mean of data
    data = data - mean(data);

    % Whitening of data
    data = sqrt(length(data)) * data / norm(data);

    % To avoid numerical problems
    data = data + eps;
end