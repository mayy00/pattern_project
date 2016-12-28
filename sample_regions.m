% method-> 1(sift)
function [ feature_matrix ] = sample_regions( dir_path, files, image_count, region_per_image, method)

feature_matrix = double([]);
file_indices = randperm(length(files), image_count);

for i = 1 : length(file_indices)
    file_name = files(file_indices(i));
    
    im = image_read(dir_path, file_name);
    [f,d] = extract_feature(im, method);
    
    region_indices = randperm(size(f, 1), min(size(f,1), region_per_image));
    feature_matrix = [feature_matrix; d(region_indices,:)];
    
end


end

