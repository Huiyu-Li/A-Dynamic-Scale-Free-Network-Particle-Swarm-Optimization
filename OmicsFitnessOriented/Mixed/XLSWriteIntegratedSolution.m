%����������ʵ����д��Excel
%�������ݣ����ս�����ҵ�����֤������Ӧ�����
%������sheet1���ȶԽ����sheet2
tic;
experiment = 1;
%����·��
savePath = 'E:\MathConstructionExercise\IntegratedResult\Solution.xlsx';
for i = 1:experiment
    dataFrom = ['E:\MathConstructionExercise\IntegratedResult\' num2str(i) '\Solution.mat'];
    Solution = load(dataFrom);
    %������sheet1���ȶԽ����sheet2
    header = num2str(i);
    letter = char('A'+ i - 1);
    xlRange1 = [letter '1'];
    %�����ҵ�������
    feature = Solution.uniqueFeature;
    [col2 row] = size(feature);
    xlRange2 = [letter '2:' letter num2str(col2 + 1)];
    xlswrite(savePath,header,'sheet1',xlRange1);
    xlswrite(savePath,feature,'sheet1',xlRange2);
    %����ȶԽ��
    align = Solution.align;
    [col3 row] = size(align);
    xlRange3 = [letter '2:' letter num2str(col3 + 1)];
    xlswrite(savePath,header,'sheet2',xlRange1);
    xlswrite(savePath,align,'sheet2',xlRange3);
end
toc;
