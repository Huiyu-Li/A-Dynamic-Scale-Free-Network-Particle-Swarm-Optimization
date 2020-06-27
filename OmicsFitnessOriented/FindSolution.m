function FindSolution( Particle, population, featureName, SavePosition)
% Ѱ���������ݵĽ��
%Ѱ���м�|���ս�������Ĵ���,(��)ȥ�ء��ȶԽ��������÷�

    %��Ӧ������
    [seq,id] = sort([Particle.pbest_mut],'descend');
    %Pbest����Ӧ������
    [Pbest( 1:population ).loc] =  Particle( id ).pbest_x;%��������Ҳ����
    
    %�����Ӧ��������������
    feature = featureName([Pbest.loc]);%�����˼�[]
    
    %����ȥ�أ�����ԭ��
    uniqueFeature = unique(feature,'stable');
    size1 = size(uniqueFeature);%[�У���]
    unique2feature = [];
    pos2feature = [];
    
    %�ҵ�uniqueFeature��ԭ����(feature)�е�λ��
    for i = 1:size1(1)
        for j = 1:population
            if( isequal (feature(j),uniqueFeature(i)) )
                unique2feature = [unique2feature j];
            end
        end
        unique2feature = [unique2feature 0];%����
    end
    size2 = size(unique2feature);
    %��unique2feature�е�λ�����ݶ�Ӧ��feature��
    for i = 1:size2(2)
        if( unique2feature(1,i) > 0 )
            pos2feature = [pos2feature feature(unique2feature(1,i))];
        else
            pos2feature = [pos2feature 0];
        end
    end
    
    %����÷�
    n = population;%score��1����score��n����n^2��ϵ����x�޹�
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
    
    %��score2����
    %��uniqueFeature����score2����
   [seq id] = sort(score2,'descend');
   uniqueFeature = uniqueFeature(id');
   unique2feature = unique2feature';
    
    %�ȶԽ��
%     PaperProvided = load(PaperProvided);
%     Paper = PaperProvided.standardFeature(:,1)';%ת�������о���
%     [align,iM,iP] = intersect(uniqueFeature,Paper,'stable');    
    
    %��������
    save(SavePosition,'Pbest','feature','uniqueFeature','unique2feature',...
        'score1','score2');
        
end


