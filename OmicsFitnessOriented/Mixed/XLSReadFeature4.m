%��9Table-S6�е�Standard-MAF(mRNA4)FearureתΪcell
%������Դ
dataFrom = 'E:\MathConstructionExercise\AttachedData\AdditionalFile9.xlsx';
[~, ~, standardFeature] = xlsread(dataFrom,'mRNA4');
%���Ǹ����һ�仰��
% standardFeature( cellfun( @(x) ~isempty(x) && isnumeric(x) && isnan(x),standardFearure) ) = {''};
%��������
path = 'E:\MathConstructionExercise\AttachedData\StandardFeature4.mat';
save(path,'standardFeature');