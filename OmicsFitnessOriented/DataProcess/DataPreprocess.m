
%对数据进行预处理并保存
%保存路径：path = 'E:\MathConstructionExercise\AttachedData\integrative'

intigrative1 = load('E:\MathConstructionExercise\AttachedData\Integrative_clinicalStage.mat');
S12 = load('E:\MathConstructionExercise\AttachedData\S12.mat');
FeatureName0 = S12.S12';

%Data 中的内容：
% 1:1117  CN
% 1118:2030  MAF
% 2031:4108  Meth
% 4109:5188  mRNA
Data0= intigrative1.Data;

data1 = Data0(:,1:1117);
featureName1 = FeatureName0(:,1:1117);
data2 = Data0(:,1118:2030);
featureName2 = FeatureName0(:,1118:2030);
data3 = Data0(:,2031:4108);
featureName3 = FeatureName0(:,2031:4108);
data4 = Data0(:,4109:5188);
featureName4 = FeatureName0(:,4109:5188);

label = intigrative1.Labels';
sampleName = intigrative1.nameOfSamples';

path = 'E:\MathConstructionExercise\AttachedData\integrative.mat';
save(path,'data1','data2','data3','data4',...
    'featureName1','featureName2','featureName3','featureName4','sampleName','label');



