
%����������ʵ����д��Excel
%�������ݣ��м������ҵ�����֤������Ӧ�����
%������sheet3���ȶԽ����sheet4
tic;
experiment = 10;
%����·��
savePath = 'E:\MathConstructionExercise\IntegratedResult\Solution.xlsx';
for i = 1:experiment
    dataFrom = ['E:\MathConstructionExercise\IntegratedResult\' num2str(i) '\IntermediateS.mat'];
    Solution = load(dataFrom);
    %������sheet3���ȶԽ����sheet4
    header = num2str(i);
    letter = char('A'+ i - 1);
    xlRange1 = [letter '1'];
    %�����ҵ�������
    feature = Solution.uniqueFeature;
    [col2 row] = size(feature);
    xlRange2 = [letter '2:' letter num2str(col2 + 1)];
    xlswrite(savePath,header,'sheet3',xlRange1);
    xlswrite(savePath,feature,'sheet3',xlRange2);
%     %����ȶԽ��
%     align = Solution.align;
%     [col3 row] = size(align);
%     xlRange3 = [letter '2:' letter num2str(col3 + 1)];
%     xlswrite(savePath,header,'sheet4',xlRange1);
%     xlswrite(savePath,align,'sheet4',xlRange3);
end
toc;