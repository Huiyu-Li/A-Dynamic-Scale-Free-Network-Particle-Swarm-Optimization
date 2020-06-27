function DetailedSLabel( Particle, population, adjacent_matrix, gbest_x, Solution, DrawingName )
%   DetailedSLabel( Particle, population, adjacent_matrix, gbest_x, Solution, DrawingName )
%������ͼ�϶Խ�������б��
%Ϊʲôͼ��������ʾʵ����ɫ��ֻ��ʾ��״��
%����ͼ�Ĵ�С��̫һ��
%������ɫ
%�ѵ���Ĵ�һ�����Ȧס����
%��̬����

%������ȡλ��
BackgroundDataPosition = 'E:\MathConstructionExercise\AttachedData\Background.mat';

    figure;%ÿ�����У����´�һ��ͼ�δ��ڣ���ֹ��ԭͼ���ػ滹���Ա���ԭͼ
    dot_a = 100;%scatter��������Ĵ�С��dot's area
    
%����һ��ͼ
    subplot(1,2,1);
    hold on;
    
    %����������
    xmin = -10;xmax = 110;ymin = xmin;ymax = xmax;
    axis([xmin xmax ymin ymax]);%Ϊ�˿���Խ���ֵ
    axis square;
    %axis equal;
    %axis manual;
   
    %��ȡ����
    nbr = length(adjacent_matrix);%��Ϊ�ڽӾ�����һ��һ�㽨������
    
    %Ԥ�ȷ����ڴ�
    X1(population) = 0;
    X2(population) = 0;
    V1(population) = 0;
    V2(population) = 0;
    PbestX1(population) = 0;
    PbestX2(population) = 0;
    NbestX1(population) = 0;
    NbestX2(population) = 0;
    
    for i = 1:population
        %λ��
        X1(i) = Particle(i).x(1);
        X2(i) = Particle(i).x(2);
        text(X1(i),X2(i),num2str(i),'Color','m');%��΢����,�������������С
        %�ٶ�
        V1(i) = Particle(i).v(1);
        V2(i) = Particle(i).v(2);
        %��������
        PbestX1(i) = Particle(i).pbest_x(1);
        PbestX2(i) = Particle(i).pbest_x(2);
        text(PbestX1(i),PbestX2(i),num2str(i),'Color','g');%��΢����,�������������С
    end
        %�ھ�����
        for i = 1:nbr%�ھӹ�ϵ���໥�ģ�������ȡʱ��Ϊ�ھ������п�ֵʱ��ȡʧ��
            NbestX1(i) = Particle(i).nbest_x(1);
            NbestX2(i) = Particle(i).nbest_x(2);
            text(NbestX1(i),NbestX2(i),num2str(i),'Color','b');%��΢����,�������������С
        end

        %�������ţ��˼ұ�������һ�����飬������ȡ
      
    %�������ͼ���뽫��ע�͵�
    %��Ӧ��ͼ�ף�������2*2��������id��λ�ã�������mut��
    BgData = load(BackgroundDataPosition);
    BX = BgData.Background.X;
    BY = BgData.Background.Y;
    BZ = BgData.Background.Z;
    contour(BX,BY,BZ,5);
    %����colormap(����һ�μ���)
    colormap cool;%colormap��figure��Ӧ����������������ͼ��mapһ������һ�ξͿ�
    %����colorbar
    BgCbarTicks = linspace(-0.07,0.2,6);
    %��ΪMut_min = [-0.0595209048640656];Mut_max = [0.121407472729296];
    %������������6�����Էֲ�����
    colorbar('Ticks',BgCbarTicks);%һ��ͼһ��colorbar
    
    %λ�� Բ ���m
    scatter(X1,X2,dot_a,'m');
    
    %�ٶ� quiver(x y u v)
    quiver(X1,X2,V1,V2,'Color','m');
    
    %�������� ����s ��g
    scatter(PbestX1,PbestX2,dot_a,'sg');
    
    %�ھ�����
    scatter(NbestX1,NbestX2,dot_a,'db');
    
    %�������� ��p ��r
    scatter(gbest_x(1),gbest_x(2),dot_a,'pr');
     
    %��ǽ��
    %eg.text(2,8,'A Simple Plot','Color','red','FontSize',14)
    n = 5;%�������
    str3 = '';
    
    %Ԥ�ȷ����ڴ�
    SX(n) = 0;
    SY(n) = 0;
    
    for i = 1:n
        SX(i) = Solution(i).p(1);%Solution�е�XY
        SY(i) = Solution(i).p(2);
        str1 = ['S' num2str(i)];
        str2 = [str1 '[' num2str(SX(i)) ',' num2str(SY(i)) ']'];
        str3 = char(str3,str2);
        text(SX,SY,str1);
    end
    text(5,20,str3);%ͨ����ͼ��֪������ط���Ӧ�Ⱥܵ�        
   
    %���⡢ͼ����������
    title(DrawingName,'Color','m','FontSize',15,'FontWeight','Bold');
    xlabel('΢��λ��-SNP','Color','m','FontSize',10,'FontWeight','Bold');
    ylabel('΢��λ��-SNP','Color','m','FontSize',10,'FontWeight','Bold');
%      legend({'��Ӧ��','λ��','�ٶ�','��������','�ھ�����','��������'},...
%          'Location','eastoutside','Orientation','horizontal','FontSize',8,'FontWeight','Bold');
     %��ʼ������٣���ע�͵�������
    legend({'��Ӧ��','λ��','�ٶ�','����','�ھ�','����'},...
         'Location','southoutside','Orientation','Horizental','FontSize',8,'FontWeight','Bold');   
    hold off;
    
%���ڽӾ���
    subplot(1,2,2);
    hold on;
    
    %����������
    axis([xmin xmax ymin ymax]);
    axis square;
%     axis equal;
%     axis manual;
    %����λ�û����д�С��΢�� %Ҫ�ǻ����ɹ�����ͼ��%�����ԣ��ټӸ�ͼ�װ�%�����color����
    
    %�������ͼ���뽫��ע�͵�
    contour(BX,BY,BZ,5);    
    %����colorbar
    colorbar('Ticks',BgCbarTicks);%һ��ͼһ��colorbar
    caxis manual;%�̶���ɫ���ã���Ӧ����hold on֮��Ļ�ͼ��
    %colorbar('off');
    %���˹��ˣ�Ϊʲôdebug��ʵ�����н����һ����
    
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

    %�����������
    scatter(SX,SY,dot_a,'sg','filled');

    %���ڽӾ����
    scatter( X1( 1:nbr ),X2( 1:nbr ),Mut_adjusted( 1:nbr ),'g');
    
%      %��ǽ��������������ٷ�������ܺã������뿴���ս���������ﲢ����
%      %�뿴���ս�����뿴˭�������˭
%      %eg.text(2,8,'A Simple Plot','Color','red','FontSize',14)
%      n = 5;%��Ǹ���
%      for i = 1:n
%          x = Solution(i).p(1);
%          y = Solution(i).p(2);
%          str = ['S' num2str(i)];
%          text(x,y,str);
%      end
    
    %����
    for i = 1:nbr
        for j = i + 1:nbr%��Ϊ�˼��ǶԳƾ���
            if(adjacent_matrix(i,j))
                line([X1(i),X1(j)], [X2(i),X2(j)],'Color','y');
            end
        end
    end
    
    for i = 1:nbr
        text(X1(i),X2(i),num2str(i),'Color','m');%��΢����,�������������С
    end
    
    %���
    %eg.text(2,8,'A Simple Plot','Color','red','FontSize',14)
    n = 5;%��Ǹ���
    for i = 1:n
        x = Solution(i).p(1);
        y = Solution(i).p(2);
        str = ['S' num2str(i)];
        text(x,y,str);
    end
    
    %���⡢ͼ����������
    title('�ڽӾ���','Color','b','FontSize',15,'FontWeight','Bold');
    xlabel('΢��λ��-SNP','Color','b','FontSize',10,'FontWeight','Bold');
    ylabel('΢��λ��-SNP','Color','b','FontSize',10,'FontWeight','Bold');
%      legend({'��Ӧ��','λ��','�ٶ�','��������','�ھ�����','��������'},...
%          'Location','eastoutside','Orientation','horizontal','FontSize',8,'FontWeight','Bold');
    legend({'λ��','�ڽӹ�ϵ'},...
         'Location','southoutside','Orientation','Horizental','FontSize',8,'FontWeight','Bold');
     hold off;
 
end

      

