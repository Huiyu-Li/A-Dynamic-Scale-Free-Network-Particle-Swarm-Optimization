%把去掉单引号的S6Excel读入MATLAB
dataFrom = 'E:\MathConstructionExercise\AttachedData\S6.xlsx';
[~, ~, S6] = xlsread(dataFrom,'B1:B5188');
%保存数据
path = 'E:\MathConstructionExercise\AttachedData\S6.mat';
save(path,'S6');