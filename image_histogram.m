function [ histogram ] = image_histogram( dir_path, file_name, model, histogram_type)
    
im = image_read(dir_path, file_name);
[points, features] = extract_feature(im, model.feature_method);

features = double(features);
features = normalize(features, model.min_normalize, model.max_normalize);

feature_assigns = zeros(1, size(features, 1));
for i = 1 : length(feature_assigns)
    D = dist([features(i, :); model.cluster_centers]'); 
    [~, id] = min(D(1,2:end)); 
    feature_assigns(i) = id;
end

tri = delaunay(points(:,1), points(:,2));
A = zeros(size(points,1), size(points,1));

for i = 1 : size(tri,1)
    A(tri(i, 1), tri(i,2)) = 1;
    A(tri(i, 2), tri(i,1)) = 1;
    
    A(tri(i, 2), tri(i,3)) = 1;
    A(tri(i, 3), tri(i,2)) = 1;
    
    A(tri(i, 1), tri(i,3)) = 1;
    A(tri(i, 3), tri(i,1)) = 1;
end

G = graph(A);
edges = table2array(G.Edges);

node_type_count = model.cluster_count;
edge_type_count = (node_type_count) * (node_type_count + 1) / 2;


%node histogram
node_histogram = zeros(1, model.cluster_count);
for i = 1 : length(feature_assigns)
    node_histogram(feature_assigns(i)) = node_histogram(feature_assigns(i)) + 1;
end

edge_histogram = zeros(1, edge_type_count);
for i = 1 : size(edges,1)
    f = edges(i,1);
    t = edges(i,2);
    ft = feature_assigns(f);
    tt = feature_assigns(t);
    
    offset = edge_type_count - (node_type_count - ft + 1) * (node_type_count - ft + 2) / 2;
    
    ind = offset + (tt - ft) + 1;
    % disp([num2str(ft), ' ', num2str(tt), ' ', num2str(offset), ' ', num2str(ind)]);
    edge_histogram(1, ind) = edge_histogram(1, ind) + 1;
end

if histogram_type == 1
    histogram = node_histogram;
elseif histogram_type == 2
    histogram = edge_histogram;
else
    histogram = [node_histogram, edge_histogram];
end

end

