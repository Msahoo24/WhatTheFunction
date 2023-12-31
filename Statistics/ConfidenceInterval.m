function [upper, lower] = ConfidenceInterval(x,alpha,dim)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: MS
% Description: Calculates upper and lower confidence intervals at the
%              1-alpha'th level.
% 
% Overview: 
% [upper,lower] = function(x,alpha,dim)
%   INPUT ARGS
%       x      --> NxM Double vector or matrix of data.
%       alpha  --> Scalar double of the target alpha value
%       dim    --> Logical scalar, Dimension of X to find mean and STD
%                  1 = rows, 0 = cols. 1 by default.
%   OUTPUT ARGS
%       upper  <-- Mx1 or 1xN double vector of upper confidence interval
%                  calculated at the z-value of norminv(alpha)
%       lower  <-- Mx1 or 1xN double vector of lower confidence interval
%                  calculated at the z-value of norminv(alpha)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    zval = norminv(alpha); % find the z val using the inverse normal
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