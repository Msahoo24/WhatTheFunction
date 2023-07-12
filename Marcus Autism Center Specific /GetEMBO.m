function outtable = GetEMBO(dat, colnames,agearr)
%% INPUT ARGS
% ____________________________________________________________________________
%
%- Function: GetEMBO(dat,colnames,agearr)
%- Author: Manash Sahoo, mksahoo@emory.edu
%- Description: Aggregates and analyzes raw eytracking by a grouping
%  variable and age, outputs average percentage_fixation for each kid by grouping
%  variable.
% ________________________________InputArgs___________________________________
% dat --------- Raw eye-tracking data file 
% colnames ---- Column names of ROIs, age, sex, 
%               Should be a cell array of column names for the following:
%               {'Eyes', 'Mouth', 'Body', 'Object', 'monthsBinned','Grouping Variable','ID'}
% agearr ------ Array of age groups that the function will group by. For
%               example: [2 3 4 5 6 9 12]
%
%
%                       
% _______________________________Example_____________________________________
% Example: tt =
% GetEMBO(dat,{'ROI1','ROI2','ROI3','ROI4','Fixation','monthsBinned',...
%                                          'CategoryName','ID'},...
%                                          [9 12 18 24],true)
%   918×7 table
% 
%          ID                      Group                   Eyes         Mouth        Body         Object      AGE
%                              categoryName                                                                      
%     ____________    _______________________________    _________    _________    _________    __________    ___
% 
%     {'00013-03'}    {'Dance'                      }     0.084383      0.78841      0.11839     0.0088161     6 
%     {'00013-03'}    {'EXCLUDE (Song - No Gesture)'}          NaN          NaN          NaN           NaN     6 
%     {'00013-03'}    {'Song - No Gesture'          }      0.14268      0.75091     0.091898       0.01451     6 
%     {'00013-03'}    {'Song - With Gesture'        }     0.062393      0.64872      0.22051      0.068376     6 
%     {'00013-03'}    {'Speech - No Gesture'        }          0.2      0.72464     0.056522      0.018841     6 
%     {'00013-03'}    {'Speech - With Gesture'      }            0     0.063584      0.85549      0.080925     6 
%     {'00175-03'}    {'Dance'                      }      0.33954      0.47412     0.095238      0.091097     6 
%     {'00175-03'}    {'EXCLUDE (Song - No Gesture)'}          NaN          NaN          NaN           NaN     6 
%     ...
%     ...
%     ...

    %% filter excludes

    dat(ismember(dat.status,'exclude'),:) = []; % remove exclude columns


    %% Error try
    if length(colnames) < 7
        error('Error: Number of Column Names Not Sufficient. Input should be a cellstr array of {eyes mouth body object ages groupvar id}');
    end

    %% Try
    
    try 
        %% Code
        % get indices of column names
        tablenames = dat.Properties.VariableNames;
        
        colind = [];
        for x = 1:length(colnames) 
            ix = find(ismember(tablenames,colnames{x}));
            
            if ~isempty(ix)
                colind(x) = ix;
            else   
                error(strcat('Unable to find column name:  ',colnames{x}));
            end
        end
            
        %% inits'ish'stuff
        grouptypes = unique(dat(:,colind(end-1)));
        
        kk = table('Size',[0 7],...
                                 'VariableTypes',...
                                                    {'cellstr','cellstr','double','double',...
                                                     'double','double','double'},...
                                 'VariableNames',...
                                                    {'ID','Group','Eyes','Mouth','Body','Object','AGE'});
        
        %% calculation
        for age = 1:length(agearr)
            agetab = dat(dat{:,colind(6)} == agearr(age),:);
            uid = unique(agetab(:,colind(end)));
            for indv = 1:size(uid,1)
                indv_table = agetab(ismember(agetab(:,colind(end)),uid(indv,:)),:);
                
                % individual output table 
                indv_out = table('Size',[size(grouptypes,1) 7],...
                                 'VariableTypes',...
                                                    {'cellstr','cellstr','double','double',...
                                                     'double','double','double'},...
                                 'VariableNames',...
                                                    {'ID','Group','Eyes','Mouth','Body','Object','AGE'});
                % assign 
                indv_out.ID = repelem(uid{indv,:},size(grouptypes,1),1);
                indv_out.Group = grouptypes;
                indv_out.AGE = repelem(agearr(age),size(grouptypes,1),1);
                
                for gtype = 1:size(grouptypes,1)
                    gtype_table = indv_table(ismember(indv_table(:,colind(end-1)),grouptypes(gtype,:)),:);
                    
                    DOI = [gtype_table(:,colind(1:5))];
                    DOIsum = sum(table2array(DOI),1);
                    DOIperc = DOIsum(1:4) / DOIsum(end);
                    
                    indv_out(gtype,3) = table(DOIperc(1));
                    indv_out(gtype,4) = table(DOIperc(2));
                    indv_out(gtype,5) = table(DOIperc(3));
                    indv_out(gtype,6) = table(DOIperc(4));
                    
                    
                end
                kk = [kk;indv_out];                           
            end
            
            
        end
        
 outtable = kk;       
        
        
        
        catch ME
            throw(ME)
    end
    
    


end

