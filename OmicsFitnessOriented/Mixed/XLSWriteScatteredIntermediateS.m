%�ѷֿ�����ʵ����д��Excel
%�������ݣ����ս�����ҵ�����֤������Ӧ�����
%������Դ��'E:\MathConstructionExercise\ScatteredResult\1\data1\Solution.mat'
%������sheet3���ȶԽ����sheet4
%%�뱣֤experimen<=6���������
tic;
experiment = 6;
%����·��
savePath = 'E:\MathConstructionExercise\ScatteredResult\Solution.xlsx';
for i = 1:experiment
    for datai = 1:4
    dataFrom = ['E:\MathConstructionExercise\ScatteredResult\' num2str(i) '\data' num2str(datai) '\IntermediateS.mat'];
    Solution = load(dataFrom);
    %������sheet3���ȶԽ����sheet4
    %��Ϊд��ͷ���䳤�ȳ���1ʱ�������������������ֶ�д��ͷ
    letter = char('A'+ (i - 1)*4 + datai - 1);
%     if(letterN > 'Z')
%         letter = [char('A'+letterN/26-1) char('A'+mod(letterN,26)-1)];
%     else
%         letter = char(letterN);
%     end
    %�����ҵ�������
    feature = Solution.uniqueFeature;
    [col2 row] = size(feature);
    xlRange2 = [letter '2:' letter num2str(col2 + 1)];
    xlswrite(savePath,feature,'sheet3',xlRange2);
    %����ȶԽ��
    align = Solution.align;
    if(~isempty(align))
    [col3 row] = size(align);
    xlRange3 = [letter '2:' letter num2str(col3 + 1)];
    xlswrite(savePath,align,'sheet4',xlRange3);
    end
    end
end
toc;

