%��MATLAB����д��excel
%data3��SampleName:A2:A198
%data3��Feature:B1:CAY1
%data3����һ�к�һ�У�B2:CAY198
integrative = load('E:\MathConstructionExercise\AttachedData\integrative.mat');
%sampleName = integrative.sampleName';%197*1
label = integrative.label';
featureName = integrative.featureName3;
data= integrative.data3;
xlsName = 'E:\MathConstructionExercise\AttachedData\data3.xlsx';
%xlswrite(xlsName,sampleName,'A2:A198');
xlswrite(xlsName,label,'A2:A198');
xlswrite(xlsName,featureName,'B1:CAY1');
xlswrite(xlsName,data,'B2:CAY198');
