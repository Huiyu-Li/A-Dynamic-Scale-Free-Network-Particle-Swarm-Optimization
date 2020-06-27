%利用S6只有前缀，S12特证名全。造自己的基因数据集：特征前缀 后缀。
%因为从结果跟踪来看，不是想象中的一个基因会表达多次，而是因为位置重复，一个基因相应有多次重复。
%S6直接做特征前缀列即可，但是后缀列需要借助EXCEl的强大功能提取所需的字符串后再返回MATLAB

S6 = load('E:\MathConstructionExercise\AttachedData\S6.mat');
S12 = load('E:\MathConstructionExercise\AttachedData\S12.mat');
S6 = S6.S6;
S12 = S12.S12;

xlsName = 'E:\MathConstructionExercise\AttachedData\S1.xlsx';
xlswrite(xlsName,S6,'A1:A5188');
xlswrite(xlsName,S12,'B1:B5188');


