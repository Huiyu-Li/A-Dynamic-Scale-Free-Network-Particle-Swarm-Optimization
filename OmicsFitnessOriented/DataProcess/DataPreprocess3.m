
%加入离散化的数据，特征名只有前缀
%保存路径：path = 'E:\MathConstructionExercise\AttachedData\integrative3'

intigrative1 = load('E:\MathConstructionExercise\AttachedData\Integrative_clinicalStage.mat');
%Data 中的内容：
% 1:1117  CN
% 1118:2030  MAF
% 2031:4108  Meth
% 4109:5188  mRNA
Data0= intigrative1.Data;
featureName0 = load('E:\MathConstructionExercise\AttachedData\S6.mat');
FeatureName0 = featureName0.S6';

data1 = Data0(:,1:1117);
data2 = Data0(:,1118:2030);
featureName1 = FeatureName0(:,1:1117);
featureName2 = FeatureName0(:,1118:2030);
featureName3 = FeatureName0(:,2031:4108);
featureName4 = FeatureName0(:,4109:5188);

data30 = load('E:\MathConstructionExercise\AttachedData\lisanData3.mat');
data3 = data30.lisanData3;
data40 = load('E:\MathConstructionExercise\AttachedData\lisanData4.mat');
data4 = data40.lisanData4;

label = intigrative1.Labels';
sampleName = intigrative1.nameOfSamples';

path = 'E:\MathConstructionExercise\AttachedData\integrative3.mat';
save(path,'data1','data2','data3','data4',...
    'featureName1','featureName2','featureName3','featureName4','sampleName','label');