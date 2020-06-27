
%把整合数据实验结果写进Excel
%保存内容：中间结果（找到的特证名，对应结果）
%特征在sheet3，比对结果再sheet4
tic;
experiment = 10;
%保存路径
savePath = 'E:\MathConstructionExercise\IntegratedResult\Solution.xlsx';
for i = 1:experiment
    dataFrom = ['E:\MathConstructionExercise\IntegratedResult\' num2str(i) '\IntermediateS.mat'];
    Solution = load(dataFrom);
    %特征在sheet3，比对结果再sheet4
    header = num2str(i);
    letter = char('A'+ i - 1);
    xlRange1 = [letter '1'];
    %保存找到的特征
    feature = Solution.uniqueFeature;
    [col2 row] = size(feature);
    xlRange2 = [letter '2:' letter num2str(col2 + 1)];
    xlswrite(savePath,header,'sheet3',xlRange1);
    xlswrite(savePath,feature,'sheet3',xlRange2);
%     %保存比对结果
%     align = Solution.align;
%     [col3 row] = size(align);
%     xlRange3 = [letter '2:' letter num2str(col3 + 1)];
%     xlswrite(savePath,header,'sheet4',xlRange1);
%     xlswrite(savePath,align,'sheet4',xlRange3);
end
toc;