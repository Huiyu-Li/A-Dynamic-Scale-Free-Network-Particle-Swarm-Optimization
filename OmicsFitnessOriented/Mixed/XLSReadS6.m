%��ȥ�������ŵ�S6Excel����MATLAB
dataFrom = 'E:\MathConstructionExercise\AttachedData\S6.xlsx';
[~, ~, S6] = xlsread(dataFrom,'B1:B5188');
%��������
path = 'E:\MathConstructionExercise\AttachedData\S6.mat';
save(path,'S6');