%���������ݣ�������ȫ���м����е�������д��Excel
%���ս����sheet1���м�����sheet2
tic;
% experiment = 10;
experiment = 1;
%����·��
savePath = 'E:\MathConstructionExercise\IntegratedResult\Solution.xlsx';
for i = 1:experiment
    dataFrom = ['E:\MathConstructionExercise\IntegratedResult\' num2str(i) '\IntermediateS.mat'];
    Solution = load(dataFrom);
    header = num2str(i);
    letter = char('A'+ i - 1);
    xlRange1 = [letter '1'];
    %�����ҵ�������
    feature = Solution.uniqueFeature;
    [col2 row] = size(feature);
    xlRange2 = [letter '2:' letter num2str(col2 + 1)];
    xlswrite(savePath,header,'sheet2',xlRange1);
    xlswrite(savePath,feature,'sheet2',xlRange2);
end
toc;