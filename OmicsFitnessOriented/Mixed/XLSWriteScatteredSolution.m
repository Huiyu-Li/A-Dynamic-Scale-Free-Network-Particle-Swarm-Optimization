%�ѷֿ�����ʵ����д��Excel
%�������ݣ����ս�����ҵ�����֤������Ӧ�����
%������Դ��'E:\MathConstructionExercise\ScatteredResult\1\data1\Solution.mat'
%������sheet1���ȶԽ����sheet2
%%�뱣֤experimen<=6���������
tic;
experiment = 2;
%����·��
savePath = 'E:\MathConstructionExercise\ScatteredResult\Solution.xlsx';
for i = 1:experiment
    for datai = 1:4
    dataFrom = ['E:\MathConstructionExercise\ScatteredResult\' num2str(i) '\data' num2str(datai) '\Solution.mat'];
    Solution = load(dataFrom);
    %������sheet1���ȶԽ����sheet2
    %��Ϊд��ͷ���䳤�ȳ���1ʱ�������������������ֶ�д��ͷ
    letter = char('A'+ (i - 1)*4 + datai - 1);
%     if(letterN > 'Z')
%         letter = [char('A'+letterN/26-1) char('A'+mod(letterN,26)-1)];
%     else
%         letter = char(letterN);
%     end
    %�����ҵ�������
    feature = Solution.uniqueFeature;
    [row col] = size(feature);
    xlRange2 = [letter '2:' letter num2str(row + 1)];
    xlswrite(savePath,feature,'sheet1',xlRange2);
%     %����ȶԽ��
%     align = Solution.align;
%     if(~isempty(align))
%     [col3 row] = size(align);
%     xlRange3 = [letter '2:' letter num2str(col3 + 1)];
%     xlswrite(savePath,align,'sheet2',xlRange3);
    end
end
toc;
