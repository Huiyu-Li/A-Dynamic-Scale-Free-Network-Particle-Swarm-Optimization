%��9Table-S6�е�StandardIntegrativeFearureתΪcell
%������Դ
dataFrom = 'E:\MathConstructionExercise\AttachedData\AdditionalFile9.xlsx';
[~, ~, standardFeature] = xlsread(dataFrom,'Integrative');%�������ܶ�����ֵ����
%��������
path = 'E:\MathConstructionExercise\AttachedData\StandardFeature.mat';
save(path,'standardFeature');
