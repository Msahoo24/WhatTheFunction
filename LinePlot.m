function [thisfigure] = LinePlot(data,x,y,Params)
    arguments
        data table {mustBeA(data,"table")}
        x string
        y string
        Params.ConfInt logical = true;
    end


    % get unique levels of x 
    xLevels = unique(data.(x));
    YY = zeros(1,numel(xLevels));
    % Store CIs here 
    upCI = zeros(1,numel(xLevels));
    loCI = zeros(1,numel(xLevels));

    

    % assign figure 
    thisfigure = figure;
    for ii = 1:numel(xLevels)
        filt = data(data.(x) == xLevels(ii),:);
        YY(ii) = mean(filt.(y));

        [u,l] = ConfidenceInterval(filt.(y), .3, 1);
        upCI(ii) = u;
        loCI(ii) = l;
    end

    plot(xLevels,YY)
    hold on;
    patchCI(thisfigure,xLevels,upCI,loCI,'r',.3)
end
% 
% months = randi([0 120],10000,1);
% meas = randomNormal(0,10,[1 10000]);
% d = table;
% d.months = months;
% d.meas = meas';