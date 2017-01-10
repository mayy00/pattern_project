function [ accuracies ] = class_based( predict, actual )
    max_label = max(actual);
    counts = zeros(1, max_label+1);
    true_counts = zeros(1, max_label+1);
    
    for i = 1 : length(actual)
        counts(actual(i) + 1) = counts(actual(i) + 1) + 1;
        if actual(i) == predict(i)
            true_counts(actual(i) + 1) = true_counts(actual(i) + 1) + 1;
        end
    end

    accuracies = true_counts ./ counts;
    
end

