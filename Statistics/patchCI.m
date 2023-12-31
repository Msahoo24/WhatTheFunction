function patchCI(targetFigure,x,upper,lower,color,alpha)
% Author: MS
%%% Input Arguments
% targetFigure: a matlab figure object where the patch should be plotted.
% x: X component 
% upper: Upper Nth confidence interval
% lower: Lower Nth confidence interval
% Color: a 1x3 vector of values > 0 < 1, or a valid matlab color identifier
% alpha: Transparency value between 0 and 1. 
    %% Input validation
    if ~isvalid(targetFigure)
        error("Target figure can't be found! Did you deleete it?")
    elseif ~isvector(x)
        error("X component is not a vector. X Component must be Nx1 or 1xN.")
    elseif ~isvector(upper)
        error("Upper confidence interval is not a vector. Upper CI must be Nx1 or 1xN.")
    elseif ~isvector(lower)
        error("Lower confidence interval is not a vector. Lower CI must be Nx1 or 1xN.")
    elseif alpha > 1 || alpha < 0 
        error("Alpha must be between 0 and 1.")
    end
    %% Patch it!
    figure(targetFigure);
    hold on;
    patch([x,fliplr(x)], [upper, fliplr(lower)],color,'FaceAlpha',alpha,'EdgeColor','none')
end