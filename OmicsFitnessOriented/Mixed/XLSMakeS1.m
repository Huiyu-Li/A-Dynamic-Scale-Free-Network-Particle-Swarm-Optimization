%����S6ֻ��ǰ׺��S12��֤��ȫ�����Լ��Ļ������ݼ�������ǰ׺ ��׺��
%��Ϊ�ӽ���������������������е�һ����������Σ�������Ϊλ���ظ���һ��������Ӧ�ж���ظ���
%S6ֱ��������ǰ׺�м��ɣ����Ǻ�׺����Ҫ����EXCEl��ǿ������ȡ������ַ������ٷ���MATLAB

S6 = load('E:\MathConstructionExercise\AttachedData\S6.mat');
S12 = load('E:\MathConstructionExercise\AttachedData\S12.mat');
S6 = S6.S6;
S12 = S12.S12;

xlsName = 'E:\MathConstructionExercise\AttachedData\S1.xlsx';
xlswrite(xlsName,S6,'A1:A5188');
xlswrite(xlsName,S12,'B1:B5188');


