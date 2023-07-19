function [S] = KaplanMeier(t,e)
    arguments
        t (:,1) double {mustBeVector}
        e (:,1) double {mustBeVector}
    end
    % KM estimate is defined as 
    % s_n-1 * (N_1 - E_1) / N_1
    d = [t e];
    S = []; % Survival Probabilities 
    T = unique(t);

    for i = 1:numel(T)
        ft = t(t == T(i));
        fe = e(t == T(i)); % Theoretically same dimensions
        
        nRisk = numel(e) - numel(ft);
        nEvents = sum(fe);
        
        if i == 1
            S(i) = 1 * (nRisk - nEvents) / nRisk;
        else
            S(i) = S(i-1) * (nRisk - nEvents) / nRisk;
        end
    end
end
