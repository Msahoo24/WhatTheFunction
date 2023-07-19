function [x,statcheck] = randomNormal(mu,var,sz)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: MS
% Description: Generate random numbers from a sampling of the normal
%              distribution with set mean and variance.
% 
% Overview: 
% x = randomNormal(mu,var)
%   INPUT ARGS
%       mu     --> scalar double. Mean of sampling distrbution
%       var    --> Scalar double. Variance of sampling distribution.
%       sz     --> 1x2 double. Size of output.
%   OUTPUT ARGS
%       x      <-- scalar double. random number from sampling distribution.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    x = var.*randn(sz(1),sz(2)) + mu;
end

