input = load('E:\Data\integrative.mat');
data1 = input.data1;
data2 = input.data2;
data3 = input.data3;
data4 = input.data4;
featureName1=input.featureName1;
featureName2=input.featureName2;
featureName3=input.featureName3;
featureName4=input.featureName4;
data = [data1 data2 data3 data4];
FeatureName = [featureName1 featureName2 featureName3 featureName4];
label = input.label;
SavePosition = 'E:\Data\integrative1.mat';
save(SavePosition,'data','featureName','label');

