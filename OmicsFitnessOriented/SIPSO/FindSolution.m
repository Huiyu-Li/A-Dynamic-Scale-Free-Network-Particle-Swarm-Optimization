function FindSolution( Particle, population, featureName, SavePosition)
% Ѱ���������ݵĽ��
%Ѱ���м�|���ս�������Ĵ���,(��)ȥ�ء��ȶԽ��������÷�

    %��Ӧ������
    [seq,id] = sort([Particle.pbest_mut],'descend');
    %Pbest����Ӧ������
    [Pbest( 1:population ).loc] =  Particle( id ).pbest_x;
    
    %�����Ӧ��������������
    %���ڷֿ����ݣ�λ�ú�featureһһ��Ӧ���������������ݣ����߲���һһ��Ӧ��Ϊ��ͳһ�����Ƕ���ӳ�䵽feature�ϡ�
    feature = featureName([Pbest.loc]);%�����˼�[]
    
    %����ȥ�أ�����ԭ��
    uniqueFeature = unique(feature,'stable');
    size1 = size(uniqueFeature);%[�У���]
    unique2feature = [];
    
    %�ҵ�uniqueFeature��ԭ����(feature)�е�λ��
    n = population*2;
    for i = 1:size1(1)
        for j = 1:n
            if( isequal (feature(j),uniqueFeature(i)) )
                unique2feature = [unique2feature
                    j];
            end
        end
        unique2feature = [unique2feature
                          0];%����
    end
    size2 = size(unique2feature);
    
    %����÷�
    %score��1����score��n����n^2��ϵ����x�޹�
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
    
    %��uniqueFeature����score2����
   [seq id] = sort(score2,'descend');
   solutionFeature = uniqueFeature(id);
    
    %��������
    save(SavePosition,'solutionFeature');
        
end


