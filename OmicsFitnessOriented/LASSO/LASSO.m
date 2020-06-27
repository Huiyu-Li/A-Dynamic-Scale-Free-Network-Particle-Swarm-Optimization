%% elastic net 之 lasso
tic;
%读入数据
input = load( 'E:\Data\integrative4.mat');
pts = input.data;%样本
class = input.label';%转化成了列矩阵,对照
featureName = input.featureName';%转化成了列矩阵，特征名

[B fitinfo] = lasso(pts,class,'CV',10,'Alpha',.5); 		%% Elastic-net with 10 fold cross validation 
lambdaindex = fitinfo.IndexMinMSE;					%% get the lambda value that has minimum mean squared error (MSE)
cutoff = fitinfo.DF(lambdaindex);					%% get the number of genomic features do not have zero regression coefficient at the minimum MSE
mse = fitinfo.MSE(lambdaindex);						%% get the value of MSE
coeff = B(:,lambdaindex);	
						%% get the regression coeffficient of all genetic features at the minimum MSE
%% 计算得分，找最终结果
    %coffe排序
    [seq,id] = sort([coeff],'descend');
    
    %结果对应到特征名
    feature = featureName([id]);%别忘了加[]
    
    %特征去重，保持原序
    uniqueFeature = unique(feature,'stable');
    size1 = size(uniqueFeature);%[行，列]
    unique2feature = [];
    pos2feature = [];
    
    %找到uniqueFeature在原特征(feature)中的位置
    for i = 1:size1(1)
        for j = 1:5188
            if( isequal (feature(j),uniqueFeature(i)) )
                unique2feature = [unique2feature j];
            end
        end
        unique2feature = [unique2feature 0];%隔板
    end
    size2 = size(unique2feature);
    
    %计算得分
    n = 100;%score（1）和score（n）是n^2关系，和x无关
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
    
    %将score2排序
    %将uniqueFeature按照score2排序
   [seq id] = sort(score2,'descend');
   solutionFeature = uniqueFeature(id');
   unique2feature = unique2feature';    
    
    %保存数据
    SavePosition = 'E:\Operation\LASSO\Solution.mat';
    save(SavePosition,'solutionFeature');      
toc;