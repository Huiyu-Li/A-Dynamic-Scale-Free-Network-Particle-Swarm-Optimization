
%�����������飬������ɢ�������ݣ�������ȫ

%������Դ
intigrative0 = load('E:\MathConstructionExercise\AttachedData\integrative2.mat');

%���data
data1 = intigrative0.data1;
data2 = intigrative0.data2;
data3 = intigrative0.data3;
data4 = intigrative0.data4;
data = [data1 data2 data3 data4];
%���feature
feature1 = intigrative0.featureName1;
feature2 = intigrative0.featureName2;
feature3 = intigrative0.featureName3;
feature4 = intigrative0.featureName4;
featureName = [feature1 feature2 feature3 feature4];
%label
label = intigrative0.label;
%����·��
path = 'E:\MathConstructionExercise\AttachedData\integrative5.mat';
save(path,'data','featureName','label');


