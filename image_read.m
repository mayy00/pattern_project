function [ im ] = image_read( dir_path, file_name )
    file_path = strcat(dir_path, file_name);
    im = imread(file_path{1,1});
    
    [~, ~, channel] = size(im);
    if channel > 1
        im = rgb2gray(im);
    end

end

