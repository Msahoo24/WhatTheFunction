function out = QuoteDEX(ids, path)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Manash K. Sahoo
% Date Last Update: 2022-Aug-09
% Information:
% QuoteDEX(IDs, WritePath)
%       IDs --> Table()
%       WritePath --> String()
%
%       Writes a .txt or .csv file with a list of DEX IDs surrounded by
%       single quotes. This is extremely useful in generating a
%       copy/pasteable list of IDs to insert into an HTSQL Query!
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if ~istable(ids)
        ids = table(ids);
    end
    varname = ids.Properties.VariableNames{1};
    

    newtable= table('Size',[size(ids,1) 1],'VariableTypes',{'string'},'VariableNames',{'id'});
    for i = 1:size(ids,1)
        id = ids.(varname)(i);
        id = strcat("'",string(id),"',");

        newtable.id(i) = id;
    end
    
    writetable(newtable,path,'QuoteStrings',false);
end