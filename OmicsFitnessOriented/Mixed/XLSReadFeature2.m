%把9Table-S6中的Standard-MAF(Mutation2)Fearure转为cell
%数据来源
dataFrom = 'E:\MathConstructionExercise\AttachedData\AdditionalFile9.xlsx';
[~, ~, standardFeature] = xlsread(dataFrom,'Mutation2');
%这是干嘛的一句话？
% standardFeature( cellfun( @(x) ~isempty(x) && isnumeric(x) && isnan(x),standardFearure) ) = {''};
%保存数据
path = 'E:\MathConstructionExercise\AttachedData\StandardFeature2.mat';
save(path,'standardFeature');