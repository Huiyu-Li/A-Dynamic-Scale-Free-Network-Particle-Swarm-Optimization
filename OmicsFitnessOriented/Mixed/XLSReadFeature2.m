%��9Table-S6�е�Standard-MAF(Mutation2)FearureתΪcell
%������Դ
dataFrom = 'E:\MathConstructionExercise\AttachedData\AdditionalFile9.xlsx';
[~, ~, standardFeature] = xlsread(dataFrom,'Mutation2');
%���Ǹ����һ�仰��
% standardFeature( cellfun( @(x) ~isempty(x) && isnumeric(x) && isnan(x),standardFearure) ) = {''};
%��������
path = 'E:\MathConstructionExercise\AttachedData\StandardFeature2.mat';
save(path,'standardFeature');