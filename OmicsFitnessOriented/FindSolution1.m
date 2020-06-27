function FindSolution1( Particle, population, featureName, SavePosition,PaperProvided)
%����ֿ�����ʱ
%Ѱ���м�|���ս�������Ĵ���,��ȥ�ء��ȶԽ����

    %��Ӧ������
    [seq,id] = sort([Particle.pbest_mut],'descend');
    %Pbest����Ӧ������
    [Pbest( 1:population ).loc] =  Particle( id ).pbest_x;%��������Ҳ����
    
    %�����Ӧ��������������
    feature = featureName([Pbest.loc]);%��֪�������Ƿ����,�����˼�[]
    %����ȥ�أ�����ԭ��
    uniqueFeature = unique(feature,'stable');
    
     %�ȶԽ��
    PaperProvided = load(PaperProvided);
    Paper = PaperProvided.standardFeature(:,1);
    [align,iM,iP] = intersect(feature,Paper,'stable');
    
    %��������
    save(SavePosition,'Pbest','uniqueFeature','align','iM','iP');
        
end