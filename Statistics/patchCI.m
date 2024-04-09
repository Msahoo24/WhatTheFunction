function [this_figure] = patchCI(xData, yData, color_line, alpha, ...
                                            confidence_interval, color, varargin)
% This function plots the xData vs yData and uses the patch function to draw confidence an upper and lower
% confidence intervals around the curve.
% 
% Author: MS & Jose Paredes
% Date: 06-19-2023
%
% xData: a 1xn vector of values
% yData: a 1xn vector of values
% upper_conf_int: upper confidence interval
% lower_conf_int: lower confidence interval
% color: a 1x3 vector of rgb values between 0 and 1
% upper_conf_int_color: a 1x3 vector of rgb values between 0 and 1
% lower_conf_int_color: a 1x3 vector of rgb values between 0 and 1
% alpha: Transparency value between 0 and 1.

% Depending on the number of arguments define the confidence interval for
% the upper and lower sections
if nargin == 6
    upper_conf_int = confidence_interval;
    lower_conf_int = confidence_interval;
    upper_conf_int_color = color;
    lower_conf_int_color = color;

elseif nargin == 8
    upper_conf_int = confidence_interval;
    lower_conf_int = cell2mat(varargin(1));
    upper_conf_int_color = color;
    lower_conf_int_color = cell2mat(varargin(2));

else
    fprintf("Check the number of input arguments\n")
    error("Usage [this_figure, this_axes] = patchCI(xData, yData, color_line, alpha, confidence_interval, color")

end

% Do some input validation
if ~(isnumeric(xData) && isvector(xData))
    error("xData must be a vector of numbers")

elseif ~(isnumeric(yData) && isvector(yData)) 
    error("yData must be a vector of numbers")

elseif length(xData) ~= length(yData)
    error("xData and yData must be of the same size")

elseif ~(isnumeric(color_line) && isequal(size(color_line), size(ones(1,3)))) 
    error("color_line must be a 3x1 vector")

elseif ~(isnumeric(upper_conf_int_color) && isequal(size(upper_conf_int_color), size(ones(1,3))))
    error("color_line must be a 3x1 vector")

elseif ~(isnumeric(lower_conf_int_color) && isequal(size(lower_conf_int_color), size(ones(1,3))))
    error("color_line must be a 3x1 vector")

elseif sum(color_line >= 0) ~= 3 || sum(color_line <= 1) ~= 3
    error("color_line must be a 3x1 vector")

elseif sum(lower_conf_int_color >= 0) ~= 3 || sum(lower_conf_int_color <= 1) ~= 3
    error("colors must be in the form of a 1x3 numerical vector which entries between 0 and 1")

elseif sum(upper_conf_int_color >= 0) ~= 3 || sum(upper_conf_int_color <= 1) ~= 3
    error("colors must be in the form of a 1x3 numerical vector which entries between 0 and 1")

elseif ~(isscalar(upper_conf_int) && isnumeric(upper_conf_int))
    error("upper_ci must be a numerical scalar")

elseif ~(isscalar(lower_conf_int) && isnumeric(lower_conf_int))
    error("lower_ci must be a numerical scalar")

elseif alpha > 1 || alpha < 0
    error("Alpha must be between 0 and 1.")
end

% Create mathcing confidence intervals for the yData
upper_conf_int = yData + upper_conf_int;
lower_conf_int = yData - lower_conf_int;

% Plot the xData vs yData and return the figure handles
this_plot = plot(xData, yData,'Color',color_line,'LineWidth', 2.0);

this_axes = this_plot.Parent;
this_figure = this_axes.Parent;

hold on;

% Plot the confidence intervals
patch([xData,fliplr(xData)], [upper_conf_int, fliplr(yData)],upper_conf_int_color,'FaceAlpha',alpha,'EdgeColor','none')
patch([xData,fliplr(xData)], [yData, fliplr(lower_conf_int)],lower_conf_int_color,'FaceAlpha',alpha,'EdgeColor','none')

hold off;

end
