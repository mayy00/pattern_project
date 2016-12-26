% method-> 1 is sift
% method-> 2 is 
function [ f, d] = extract_feature(im, method)
    
    if method == 1 
        [f, d] = vl_sift(single(im)); %f: frames d:decriptors
        f = f';
        f = f(:,1:2);
        d = d';
        
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

end

