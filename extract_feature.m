% method-> 1 is sift
% method-> 2 is 
function [ points, features] = extract_feature(im, method)
    
    if method == 1 
        [points, features] = vl_sift(single(im), 'PeakThresh', 5); %f: frames d:decriptors
        points = points';
        points = points(:,1:2);
        features = features';
    end
    %{
    elseif method == 2
          points = detectSURFFeatures(im);
          [features, valid_points] = extractFeatures(im, points);
          f = features; %??
          d = valid_points; %??
    else
        [featureVector,hogVisualization] = extractHOGFeatures(im);
        f = featureVector; %??
        d = hogVisualization;%??
    end
    %}

end

