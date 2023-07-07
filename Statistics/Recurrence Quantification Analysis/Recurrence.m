function REC = Recurrence(RecMat)
% Calculate the percentage recurrence using the upper triangle (excluding
% the line of incidence) of the recurrence matrix. 
    t = triu(RecMat,1); % only above the major diagonal 
    r = 0;
    N = size(t,1);
    Tn = 2*N; % Recurrence normalization coefficient, should be sum of all t(i) but we don't have that lol
    for i = 1:size(t,1)-1
        for j = 1:size(t,1)
            j = i + 1;
            r = r + t(i,j);
        end
    end

    REC = 100*(r/((N-1)*Tn)); % Assuming each fixation duration is 1s
end

