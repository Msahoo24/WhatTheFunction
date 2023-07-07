function [upper, lower] = ConfidenceInterval(x,alpha,dim)
    % Calculates lower and upper confidence intervals using the formula: 
    % CI = Xbar - Zval * (SD / sqrt(N))
    
    % x: non-scalar set of data
    % alpha: desired alpha from 0-1
    % dim: dimension of interest, default 1 (by rows)

    

    zval = norminv(alpha); % find the z val
    if nargin < 3
        dim = 1;
    end

    N = size(x,dim);

    if ~isvector(x) % if not vector
        upper = mean(x,dim) + (zval * (std(x,0,dim) / sqrt(N)));
        lower = mean(x,dim) - (zval * (std(x,0,dim) / sqrt(N)));
    else % if is vector
        upper = mean(x) + (zval * (std(x) / sqrt(N)));
        lower = mean(x) - (zval * std(x) / sqrt(N));
    end
end