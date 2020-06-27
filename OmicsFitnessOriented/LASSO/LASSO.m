%% elastic net ֮ lasso
tic;
%��������
input = load( 'E:\Data\integrative4.mat');
pts = input.data;%����
class = input.label';%ת�������о���,����
featureName = input.featureName';%ת�������о���������

[B fitinfo] = lasso(pts,class,'CV',10,'Alpha',.5); 		%% Elastic-net with 10 fold cross validation 
lambdaindex = fitinfo.IndexMinMSE;					%% get the lambda value that has minimum mean squared error (MSE)
cutoff = fitinfo.DF(lambdaindex);					%% get the number of genomic features do not have zero regression coefficient at the minimum MSE
mse = fitinfo.MSE(lambdaindex);						%% get the value of MSE
coeff = B(:,lambdaindex);	
						%% get the regression coeffficient of all genetic features at the minimum MSE
%% ����÷֣������ս��
    %coffe����
    [seq,id] = sort([coeff],'descend');
    
    %�����Ӧ��������
    feature = featureName([id]);%�����˼�[]
    
    %����ȥ�أ�����ԭ��
    uniqueFeature = unique(feature,'stable');
    size1 = size(uniqueFeature);%[�У���]
    unique2feature = [];
    pos2feature = [];
    
    %�ҵ�uniqueFeature��ԭ����(feature)�е�λ��
    for i = 1:size1(1)
        for j = 1:5188
            if( isequal (feature(j),uniqueFeature(i)) )
                unique2feature = [unique2feature j];
            end
        end
        unique2feature = [unique2feature 0];%����
    end
    size2 = size(unique2feature);
    
    %����÷�
    n = 100;%score��1����score��n����n^2��ϵ����x�޹�
    x = 10;  
    for i = 1:5188
        rank(i,1)=n/i;
        score1(i,1)=rank(i,1)*(n-i+1);
    end
    summ = 0;
    j = 1;
    for i = 1:size2(2)
        if( unique2feature(1,i) > 0 )
            summ = summ + score1( unique2feature(i));
        else
            score2(j,1) = summ;
            summ = 0;
            j = j + 1;
        end
    end
    
    %��score2����
    %��uniqueFeature����score2����
   [seq id] = sort(score2,'descend');
   solutionFeature = uniqueFeature(id');
   unique2feature = unique2feature';    
    
    %��������
    SavePosition = 'E:\Operation\LASSO\Solution.mat';
    save(SavePosition,'solutionFeature');      
toc;