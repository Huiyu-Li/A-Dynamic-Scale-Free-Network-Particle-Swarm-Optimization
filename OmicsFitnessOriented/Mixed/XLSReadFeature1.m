%��9Table-S6�е�Standard-MAF(CN1)FearureתΪcell
%������Դ
dataFrom = 'E:\MathConstructionExercise\AttachedData\AdditionalFile9.xlsx';
[~, ~, standardFeature] = xlsread(dataFrom,'CN1');
%���Ǹ����һ�仰��
% standardFeature( cellfun( @(x) ~isempty(x) && isnumeric(x) && isnan(x),standardFearure) ) = {''};
%��������
path = 'E:\MathConstructionExercise\AttachedData\StandardFeature1.mat';
save(path,'standardFeature');