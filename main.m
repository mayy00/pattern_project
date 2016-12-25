cluster_count = 50;
sample_image_count = 500;
region_per_image = 12;
feature_method = 1; % sift

dir_path = '../dataset/Images/';

[train_names, test_names, train_labels, test_labels] = load_data();


% feature_matrix = sample_regions('../dataset/Images/', train_names, sample_image_count, region_per_image, feature_method);
feature_matrix = double(importdata('cache/feature_matrix_500_12_1.mat'));
min_normalize = min(feature_matrix);
max_normalize = max(feature_matrix);

% feature_matrix = normalize(feature_matrix, min_normalize, max_normalize);
% [~, cluster_centers] = kmeans(feature_matrix, cluster_count, 'MaxIter', 1000);
cluster_centers = importdata('cache/cluster_centers_500_12_1_50.mat');

im = image_read(dir_path, train_names(1));
[f,d] = extract_feature(im, feature_method);