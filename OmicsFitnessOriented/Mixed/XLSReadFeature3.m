%��9Table-S6�е�Standard-MAF(Methy3)FearureתΪcell
%������Դ
dataFrom = 'E:\MathConstructionExercise\AttachedData\AdditionalFile9.xlsx';
[~, ~, standardFeature] = xlsread(dataFrom,'Methy3');
%���Ǹ����һ�仰��
% standardFeature( cellfun( @(x) ~isempty(x) && isnumeric(x) && isnan(x),standardFearure) ) = {''};
%��������
path = 'E:\MathConstructionExercise\AttachedData\StandardFeature3.mat';
save(path,'standardFeature');