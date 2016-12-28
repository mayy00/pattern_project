function [train_names, test_names, train_labels, test_labels] = load_data()

data = importdata('labels.txt');
size = length(data(1).data);
train_names = importdata('TrainImages.txt');
test_names = importdata('TestImages.txt');
train_labels = zeros(1, length(train_names));
test_labels = zeros(1, length(test_names));

map = containers.Map();
for i=1:size
   map(data(1).textdata{i, 1}) = data(1).data(i,1);
end

for i=1:length(train_names)
   train_labels(i) = map(train_names{i,1});
end

for i=1:length(test_names)
   test_labels(i) = map(train_names{i,1});
end


end

