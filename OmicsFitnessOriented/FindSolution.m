function FindSolution( Particle, population, featureName, SavePosition)
% 寻找整块数据的结果
%寻找中间|最终解决方案的代码,(不)去重、比对结果、计算得分

    %适应度排序
    [seq,id] = sort([Particle.pbest_mut],'descend');
    %Pbest按适应度排序
    [Pbest( 1:population ).loc] =  Particle( id ).pbest_x;%无需声明也可以
    
    %结果对应到特征名并保存
    feature = featureName([Pbest.loc]);%别忘了加[]
    
    %特征去重，保持原序
    uniqueFeature = unique(feature,'stable');
    size1 = size(uniqueFeature);%[行，列]
    unique2feature = [];
    pos2feature = [];
    
    %找到uniqueFeature在原特征(feature)中的位置
    for i = 1:size1(1)
        for j = 1:population
            if( isequal (feature(j),uniqueFeature(i)) )
                unique2feature = [unique2feature j];
            end
        end
        unique2feature = [unique2feature 0];%隔板
    end
    size2 = size(unique2feature);
    %将unique2feature中的位置数据对应到feature上
    for i = 1:size2(2)
        if( unique2feature(1,i) > 0 )
            pos2feature = [pos2feature feature(unique2feature(1,i))];
        else
            pos2feature = [pos2feature 0];
        end
    end
    
    %计算得分
    n = population;%score（1）和score（n）是n^2关系，和x无关
    x = 10; 
    for i = 1:population
        rank(i,1)=n/i;
        score1(i,1)=rank(i,1)*(n-i+1);
    end
    summ = 0;
    j = 1;
    %size2 = size(unique2feature);
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
   uniqueFeature = uniqueFeature(id');
   unique2feature = unique2feature';
    
    %比对结果
%     PaperProvided = load(PaperProvided);
%     Paper = PaperProvided.standardFeature(:,1)';%转化成了列矩阵
%     [align,iM,iP] = intersect(uniqueFeature,Paper,'stable');    
    
    %保存数据
    save(SavePosition,'Pbest','feature','uniqueFeature','unique2feature',...
        'score1','score2');
        
end


