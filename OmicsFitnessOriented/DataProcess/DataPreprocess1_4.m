
%对数据重新组合data1-4(data,featureName,label)，加入离散化的数据，特征名只有前缀
%无法实现自动取数据，每次需要改动：data,featureName,path
%数据来源
intigrative0 = load('E:\MathConstructionExercise\AttachedData\integrative3.mat');
  
data = intigrative0.data4;
featureName = intigrative0.featureName4;
label = intigrative0.label;

%保存路径：path = 'E:\MathConstructionExercise\data1-4\'
path = 'E:\MathConstructionExercise\AttachedData\data4.mat';
save(path,'data','featureName','label');
