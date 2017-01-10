dir_path = '../dataset/Images/';

ccs = [60];
for ccind = 1 : length(ccs)


    model = {};
    model.cluster_count = ccs(ccind);
    model.feature_method = 1; % sift
    sample_image_count = 500;
    region_per_image = 12;
    histogram_type = 3;


    [train_names, test_names, train_labels, test_labels] = load_data();

    feature_matrix = double(sample_regions('../dataset/Images/', train_names, sample_image_count, region_per_image, model.feature_method));
    % feature_matrix = double(importdata('cache/feature_matrix_500_12_1.mat'));
    model.min_normalize = min(feature_matrix);
    model.max_normalize = max(feature_matrix);

    feature_matrix = normalize(feature_matrix, model.min_normalize, model.max_normalize);
    [~, model.cluster_centers] = kmeans(feature_matrix, model.cluster_count, 'MaxIter', 1000);
    % model.cluster_centers = importdata('cache/cluster_centers_500_12_1_50.mat');

    trainX = [];
    for i = 1 : size(train_labels, 2)
        histogram = image_histogram(dir_path, train_names(i), model, histogram_type);
        trainX = [trainX; histogram]; 
        % disp(['Train:', num2str(i)]);
    end

    testX = [];
    for i = 1 : size(test_labels, 2)
        histogram = image_histogram(dir_path, train_names(i), model, histogram_type);
        testX = [testX; histogram]; 
        % disp(['Test:', num2str(i)]);
    end

    minTrainX = min(trainX);
    maxTrainX = max(trainX);
    trainXNorm = normalize(trainX, minTrainX, maxTrainX);
    testXNorm = normalize(testX, minTrainX, maxTrainX);
    t = templateSVM('KernelFunction', 'linear');
    learn = fitcecoc(trainXNorm, train_labels, 'Learners', t);
    predict_labels = predict(learn, testXNorm);
    acc = sum(predict_labels' == test_labels) / 1340;
    
    disp(['Accuracy cluster:', num2str(model.cluster_count), ' acc:', num2str(acc)]);
    fileID = fopen('exp.txt','a');
    fprintf(fileID,'%s', ['Accuracy cluster:', num2str(model.cluster_count), ' acc:', num2str(acc)]);
    fclose(fileID);

    cache_path = strcat('cache/kmeans', num2str(model.cluster_count), '_fm_', num2str(model.feature_method), '_ht_', num2str(histogram_type), '.mat');
    save(cache_path);
end