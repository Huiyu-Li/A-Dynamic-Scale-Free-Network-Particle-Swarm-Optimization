%把分块数据实验结果写进Excel
%保存内容：最终结果（找到的特证名，对应结果）
%数据来源：'E:\MathConstructionExercise\ScatteredResult\1\data1\Solution.mat'
%特征在sheet3，比对结果再sheet4
%%请保证experimen<=6，否则出错
tic;
experiment = 6;
%保存路径
savePath = 'E:\MathConstructionExercise\ScatteredResult\Solution.xlsx';
for i = 1:experiment
    for datai = 1:4
    dataFrom = ['E:\MathConstructionExercise\ScatteredResult\' num2str(i) '\data' num2str(datai) '\IntermediateS.mat'];
    Solution = load(dataFrom);
    %特征在sheet3，比对结果再sheet4
    %因为写表头当其长度超过1时常出错，所以这里我们手动写表头
    letter = char('A'+ (i - 1)*4 + datai - 1);
%     if(letterN > 'Z')
%         letter = [char('A'+letterN/26-1) char('A'+mod(letterN,26)-1)];
%     else
%         letter = char(letterN);
%     end
    %保存找到的特征
    feature = Solution.uniqueFeature;
    [col2 row] = size(feature);
    xlRange2 = [letter '2:' letter num2str(col2 + 1)];
    xlswrite(savePath,feature,'sheet3',xlRange2);
    %保存比对结果
    align = Solution.align;
    if(~isempty(align))
    [col3 row] = size(align);
    xlRange3 = [letter '2:' letter num2str(col3 + 1)];
    xlswrite(savePath,align,'sheet4',xlRange3);
    end
    end
end
toc;

