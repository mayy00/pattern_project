% method-> 1 is sift
function [ f, d] = extract_feature(im, method)
    
    if method == 1
        [f, d] = vl_sift(single(im));
        f = f';
        f = f(:,1:2);
        d = d';
        
    end

end

