
%�������������data1-4(data,featureName,label)��������ɢ�������ݣ�������ֻ��ǰ׺
%�޷�ʵ���Զ�ȡ���ݣ�ÿ����Ҫ�Ķ���data,featureName,path
%������Դ
intigrative0 = load('E:\MathConstructionExercise\AttachedData\integrative3.mat');
  
data = intigrative0.data4;
featureName = intigrative0.featureName4;
label = intigrative0.label;

%����·����path = 'E:\MathConstructionExercise\data1-4\'
path = 'E:\MathConstructionExercise\AttachedData\data4.mat';
save(path,'data','featureName','label');
