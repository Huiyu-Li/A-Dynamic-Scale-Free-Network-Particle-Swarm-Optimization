%����ȶԽ���е�align:load('E:\MathConstructionExercise\1\data1-4\Solution.mat')
%����λ��'E:\MathConstructionExercise\1\data1-4\Align.mat'

%ʵ�����
experiment = 1;
Align = struct();
for exper = 1:experiment
    for Datai = 1:4
        %������Դ
        alignFrom = ['E:\MathConstructionExercise\',num2str(exper),'\data',num2str(Datai),'\Solution.mat'];
        alignData = load(alignFrom);
        align = cell2str(alignData.align)';
        field =['align',num2str(Datai)]; 
        Align.field = align;
    end
    savePath = ['E:\MathConstructionExercise\',num2str(exper),'\data',num2str(Datai),'\Align.mat'];
    save(savePath,'Align');
end

