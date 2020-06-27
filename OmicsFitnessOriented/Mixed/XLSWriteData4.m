%把MATLAB数据写进excel
%data4放SampleName:A2:A198
%data4放Feature:B1:AOO1
%data4留出一行和一列：B2:AOO198
integrative = load('E:\MathConstructionExercise\AttachedData\integrative.mat');
%sampleName = integrative.sampleName';%197*1
featureName = integrative.featureName4;
label = integrative.label';
data= integrative.data4;
xlsName = 'E:\MathConstructionExercise\AttachedData\data4.xlsx';
%xlswrite(xlsName,sampleName,'A2:A198');
xlswrite(xlsName,featureName,'B1:AOO1');
xlswrite(xlsName,label,'A2:A198');
xlswrite(xlsName,data,'B2:AOO198');

