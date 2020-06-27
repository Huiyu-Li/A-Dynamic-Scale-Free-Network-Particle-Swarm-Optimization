function FindSolution1( Particle, population, featureName, SavePosition,PaperProvided)
%处理分块数据时
%寻找中间|最终解决方案的代码,不去重、比对结果、

    %适应度排序
    [seq,id] = sort([Particle.pbest_mut],'descend');
    %Pbest按适应度排序
    [Pbest( 1:population ).loc] =  Particle( id ).pbest_x;%无需声明也可以
    
    %结果对应到特征名并保存
    feature = featureName([Pbest.loc]);%不知道这样是否可以,别忘了加[]
    %特征去重，保持原序
    uniqueFeature = unique(feature,'stable');
    
     %比对结果
    PaperProvided = load(PaperProvided);
    Paper = PaperProvided.standardFeature(:,1);
    [align,iM,iP] = intersect(feature,Paper,'stable');
    
    %保存数据
    save(SavePosition,'Pbest','uniqueFeature','align','iM','iP');
        
end