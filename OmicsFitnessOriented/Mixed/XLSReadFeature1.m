%把9Table-S6中的Standard-MAF(CN1)Fearure转为cell
%数据来源
dataFrom = 'E:\MathConstructionExercise\AttachedData\AdditionalFile9.xlsx';
[~, ~, standardFeature] = xlsread(dataFrom,'CN1');
%这是干嘛的一句话？
% standardFeature( cellfun( @(x) ~isempty(x) && isnumeric(x) && isnan(x),standardFearure) ) = {''};
%保存数据
path = 'E:\MathConstructionExercise\AttachedData\StandardFeature1.mat';
save(path,'standardFeature');