function LunWenTracking( Particle, adjacent_matrix,population)
%   LunWenTracking( Particle, adjacent_matrix)

    figure;%ÿ�����У����´�һ��ͼ�δ��ڣ���ֹ��ԭͼ���ػ滹���Ա���ԭͼ
    %û�������ᣬû��ͼ�������ñ��
    %����������
    xmin = -10;xmax = 110;ymin = xmin;ymax = xmax;
    axis([xmin xmax ymin ymax]);%Ϊ�˿���Խ���ֵ
    axis square;
  
    %axis equal;
    %axis manual;
    
    nbr = length(adjacent_matrix);%��Ϊ�ڽӾ�����һ��һ�㽨������
    
    %Ԥ�ȷ����ڴ�
    X1(population) = 0;
    X2(population) = 0;
    NbestX1(population) = 0;
    NbestX2(population) = 0;
    for i = 1:population
        %λ��
        X1(i) = Particle(i).x(1);
        X2(i) = Particle(i).x(2);
    end
        %�ھ�����
        for i = 1:nbr%�ھӹ�ϵ���໥�ģ�������ȡʱ��Ϊ�ھ������п�ֵʱ��ȡʧ��
            NbestX1(i) = Particle(i).nbest_x(1);
            NbestX2(i) = Particle(i).nbest_x(2);
            text(NbestX1(i),NbestX2(i),num2str(i),'Color','b');%��΢����,�������������С
        end
        %�ھ�����
        for i = 1:nbr%�ھӹ�ϵ���໥�ģ�������ȡʱ��Ϊ�ھ������п�ֵʱ��ȡʧ��
            NbestX1(i) = Particle(i).nbest_x(1);
            NbestX2(i) = Particle(i).nbest_x(2);
%             text(NbestX1(i),NbestX2(i),num2str(i),'Color','b');%��΢����,�������������С
        end

    %Ϊ�ڽӾ����е�Ĵ�С-��Ӧ�� ��׼��
    Mut = [Particle.mut];
    Mmax = max(Mut);
    Mmin = min(Mut);
    difference = Mmax - Mmin;
    Mut_norm = (Mut - Mmin)/difference;
    %Ŀ������[100,300]-[a,b] [mul,add]-[(b - a),a]
    %Ŀ�������ڽӾ����е�Ĵ�С������Ӧ�ȣ�
    %������ڱ�֤��Ĵ�С���ʵ�����¾����������
    %��������г˷���������С����ļ��㸴�Ӷ�
    mul = 200;add = 100;
    Mut_adjusted = round(Mut_norm*mul + add);

    %ÿ��ֻ�����ھӵĵ�
    scatter( X1( 1:nbr ),X2( 1:nbr ),Mut_adjusted( 1:nbr ),'m' );
    
    %����
    for i = 1:nbr
        for j = i + 1:nbr%��Ϊ�˼��ǶԳƾ���
            if(adjacent_matrix(i,j))
                line([X1(i),X1(j)], [X2(i),X2(j)],'Color','b');
            end
        end
    end
    
    %���
    for i = 1:nbr
        text(X1(i),X2(i),num2str(i),'Color','y');%��΢����,�������������С
    end
    axis off;
    hold off;
 
end

