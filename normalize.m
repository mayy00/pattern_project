function [ normalized ] = normalize( X, min, max )

normalized = bsxfun(@minus, X, min);
normalized = bsxfun(@rdivide, normalized, (max-min));

end

