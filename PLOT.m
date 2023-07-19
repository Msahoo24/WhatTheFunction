function [thisplot] = PLOT(data,x,y,NameValueArgs)
    arguments
        data {mustBeA(data,"table")}
        x char 
        y char
        
        NameValueArgs.LineWidth (1,1) double = 2;
        NameValueArgs.LineStyle string = "-";
        NameValueArgs.Marker string = ".";
        NameValueArgs.ColorBy string = "None";
        NameValueArgs.MarkerSize (1,1) double = 10;

        NameValueArgs.ConfidenceInterval (1,1) logical = false;
        NameValueArgs.PlotType string = "LinePlot";
    end
    %% data parsing 
    u = unique(y);
    for i = 1:size(y,1)
        
    end
    
end