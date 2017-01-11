load('cache/kmeans60_fm_1_ht_3');
Ks = [5, 10, 50, 100, 200, 300, 400, 500, 1000, 1500];

all_class_acs = zeros(length(Ks), 67);
all_acs = zeros(1, length(Ks));
X = [trainXNorm; testXNorm];
[evectors, ~, evalues, ~, ~, ~] = pca(X);

for i = 1 : length(Ks)

K = Ks(i);

% [evectors, ~, evalues, ~, ~, ~] = pca(X);
transformed = X * evectors(:, 1:K);

minX = min(transformed);
maxX = max(transformed);

transformedNorm = normalize(transformed, minX, maxX);
trainTX = transformed(1:size(trainXNorm, 1), :);
testTX = transformed(size(trainXNorm, 1) + 1 : size(transformedNorm, 1),  :);

t = templateSVM('KernelFunction', 'linear', 'BoxConstraint', 10);
learn = fitcecoc(trainTX, train_labels, 'Learners', t);
predict_labels = predict(learn, testTX);
acc = sum(predict_labels' == test_labels) / size(test_labels, 2);

class_accs = class_based(int16(predict_labels'), int16(test_labels));
all_acs(i) = acc;   
all_class_acs(i, :) = class_accs;

% ylim([0,1]);
% xlim([0,67]);

end