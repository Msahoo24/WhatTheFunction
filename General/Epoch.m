function [result,censor,start,stop] = Epoch(X,P,M,EV)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Manash K. Sahoo
% Description: Finds all repeated sequences of P in X, which can be
% interrupted by values in M and are censored if the end value is EV. 
% 
% These repeated values are stored in result{}.
% The censor[] output argument is a 1xK array of censoring values, where K
% is the length of result{}. The start[] and stop[] values indicate the
% indices of each epoch.
%
% This function is particularly valuable in survival analyses for ET data,
% hence the censoring output argument. 
%
% Overview: 
% [result,censor,start,stop] = Epoch(X,P,M)
%   INPUT ARGS
%       X --> Double Nx1 or 1xN..........| Sequence of values to parse
%       P --> Double Scalar..............| Target value
%       M --> Double Scalar or 1xN.......| Values in which can interrupt
%                                          sequences of P
%   OUTPUT ARGS
%       result <-- 1xN Cell Array of Double Arrays
%       censor <-- 1xK Logical Array, where K is the length of result{}
%       start  <-- 1xN Double Array, of start indices. 
%       stop   <-- 1xN Double Array, same as aboove but for stops.
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    CurrentFixation = [];
    result = {};
    censor = [];

    start = [];
    stop = [];

    flag = 0;
    tempfixation = [];
    C = 1;
    for i = 1:numel(X)
        if X(i) == P
            CurrentFixation = [CurrentFixation X(i)];
            flag = 1;
            if i == numel(X)
                start = [start (i-numel(CurrentFixation))];
                stop = [stop i];

                result{C} = CurrentFixation;
                censor(C) = 1; 
            end
        elseif ismember(X(i),M) & flag == 1
            CurrentFixation = [CurrentFixation X(i)];
        elseif (X(i) ~= P & ~ismember(X(i),M)) 
            start = [start (i-numel(CurrentFixation))];
            stop = [stop i];

            result{C} = CurrentFixation;
            if ~isempty(CurrentFixation)
                if X(i) == EV
                    censor(C) = 1;
                else
                    censor(C) = 0;
                end
            else
                censor(C) = 0;
            end
            CurrentFixation = [];
            C = C+1;
        end
    end
    ix = find(cell2mat(cellfun(@(x)(size(x,2)),result,'UniformOutput',false)) == 0);
    result(ix) = [];
    censor(ix) = [];
    start(ix) = [];
    stop(ix) = [];
end
