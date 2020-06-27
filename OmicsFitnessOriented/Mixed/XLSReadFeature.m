%把9Table-S6中的StandardIntegrativeFearure转为cell
%数据来源
dataFrom = 'E:\MathConstructionExercise\AttachedData\AdditionalFile9.xlsx';
[~, ~, standardFeature] = xlsread(dataFrom,'Integrative');%这样才能读非数值内容
%保存数据
path = 'E:\MathConstructionExercise\AttachedData\StandardFeature.mat';
save(path,'standardFeature');
