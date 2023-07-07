function [FsMeasured,FsRound] = FindFs(x_vec)
 % --------Syntax---------
% % [FsMeasured,FsRound] = FindFs(x_vec)
 % --------Descrip--------
% % Computes the exact sampling rate FsMeasured, as well as 
% % the sampling rate rounded to the nearest 100th, FsRound
% % with a signal time vector, x_vec.
 % -----------------------


    dt = diff(x_vec);
    avgdt = mean(dt);
    FsMeasured = abs(1/avgdt);
    
    FsRound = round(FsMeasured,2);


end
