function FindSolution( Particle, population, featureName, SavePosition)
% 寻找整块数据的结果
%寻找中间|最终解决方案的代码,(不)去重、比对结果、计算得分

    %适应度排序
    [seq,id] = sort([Particle.pbest_mut],'descend');
    %Pbest按适应度排序
    [Pbest( 1:population ).loc] =  Particle( id ).pbest_x;
    
    %结果对应到特征名并保存
    %对于分块数据，位置和feature一一对应；但对于整合数据，二者并非一一对应。为了统一，我们都先映射到feature上。
    feature = featureName([Pbest.loc]);%别忘了加[]
    
    %特征去重，保持原序
    uniqueFeature = unique(feature,'stable');
    size1 = size(uniqueFeature);%[行，列]
    unique2feature = [];
    
    %找到uniqueFeature在原特征(feature)中的位置
    n = population*2;
    for i = 1:size1(1)
        for j = 1:n
            if( isequal (feature(j),uniqueFeature(i)) )
                unique2feature = [unique2feature
                    j];
            end
        end
        unique2feature = [unique2feature
                          0];%隔板
    end
    size2 = size(unique2feature);
    
    %计算得分
    %score（1）和score（n）是n^2关系，和x无关
    x = 10; 
    for i = 1:n
        rank(i,1)=n/i;
        score1(i,1)=rank(i,1)*(n-i+1);
    end
    sum = 0;
    j = 1;
    %size2 = size(unique2feature);
    for i = 1:size2(1)
        if( unique2feature(i,1) > 0 )
            sum = sum + score1( unique2feature(i,1));
        else
            score2(j,1) = sum;
            sum = 0;
            j = j + 1;
        end
    end
    
    %将uniqueFeature按照score2排序
   [seq id] = sort(score2,'descend');
   solutionFeature = uniqueFeature(id);
    
    %保存数据
    save(SavePosition,'solutionFeature');
        
end


