function FeatureCompare()
%�ȶ�'E:\MathConstructionExercise\ʵ�����\data1-4\Solution.mat'->feature
%  ��'E:\MathConstructionExercise\AttachedData\StandardFeature1-4.mat'->featureName
%�ȶԽ������
expr = 1;
for Datai = 1:4
    %MyFound = load(['E:\MathConstructionExercise\num2str(expr)\data',num2str(Datai),'\Solution.mat']);
    MyFound = load('E:\MathConstructionExercise\1\data1\Solution.mat');
    PaperProvided =  load('E:\MathConstructionExercise\AttachedData\StandardFeature1.mat');
    Mine = MyFound.feature;
    Paper = PaperProvided.standardFeature;
    [align,iM,iP] = intersect(Mine,Paper);
    
end

