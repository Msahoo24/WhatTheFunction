function dist = dtwf(x,y)
% Description: This is not my function. This is a fix provided by
% Srivardhan Gadila, so that the builtin DTW function is able to be passed
% in as a handle to clustering functions such as @kmeans. Here is the link
% to the MATLAB Answers where this fix was provided:
% https://www.mathworks.com/matlabcentral/answers/742007-clustering-time-series-with-dtw

% Author: Srivardhan Gadila


m2 = size(y,1);
dist = zeros(m2,1);
for i=1:m2
    dist(i) = dtw(x,y(i,:));
end
end