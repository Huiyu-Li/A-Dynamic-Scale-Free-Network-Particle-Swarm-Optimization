function Tracking( Particle, population, adjacent_matrix, gbest_x, titleStr, iter)
%   Tracking( Particle, population, adjacent_matrix, gbest_x, titleStr, iter )
%Ϊʲôͼ��������ʾʵ����ɫ��ֻ��ʾ��״��
%����ͼ�Ĵ�С��̫һ��
%������ɫ
%�ѵ���Ĵ�һ�����Ȧס����
%��̬���⣬��ȡû����һ�γ�һ��ͼ

%������ȡλ��
% BackgroundDataPosition = 'E:\MathConstructionExercise\AttachedData\Background.mat';

    figure;%ÿ�����У����´�һ��ͼ�δ��ڣ���ֹ��ԭͼ���ػ滹���Ա���ԭͼ
    dot_a = 100;%scatter��������Ĵ�С
    
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
    %�ؼ��ǰѽṹ��ĳ���ֶε�����ת���ɾ������ʽ������ѭ���һ�û���뵽������ʽ
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
%         %��Ӧ��(��ǰλ�õģ�����ɾ���)       
%         Mut(X1(i),X2(i)) = round( (Particle(i).mut - Mmin)*D + add );
%         Adjusted_Mut(i) =  Mut(X1(i),X2(i));
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
      
%     %�������ͼ���뽫��ע�͵�
%     %��Ӧ��ͼ�ף�������2*2��������id��λ�ã�������mut��
%     BgData = load(BackgroundDataPosition);
%     BX = BgData.Background.X;
%     BY = BgData.Background.Y;
%     BZ = BgData.Background.Z;
%     contour(BX,BY,BZ,5);
%     %����colormap(����һ�μ���)
%     colormap cool;%colormap��figure��Ӧ����������������ͼ��mapһ������һ�ξͿ�
%     %����colorbar
%     BgCbarTicks = linspace(-0.07,0.2,6);
%     %��ΪMut_min = [-0.0595209048640656];Mut_max = [0.121407472729296];
%     %������������6�����Էֲ�����
%     colorbar('Ticks',BgCbarTicks);%һ��ͼһ��colorbar
    
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
   
    %���⡢ͼ����������
    title([titleStr,num2str(iter)],'Color','b','FontSize',15,'FontWeight','Bold');
    xlabel('΢��λ��-SNP','Color','b','FontSize',10,'FontWeight','Bold');
    ylabel('΢��λ��-SNP','Color','b','FontSize',10,'FontWeight','Bold');
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
    
%     %�������ͼ���뽫��ע�͵�
%     contour(BX,BY,BZ,5);
%     caxis manual;%�̶���ɫ���ã���Ӧ����hold on֮��Ļ�ͼ�� 
%     %����colorbar
%     colorbar('Ticks',BgCbarTicks);%һ��ͼһ��colorbar
%     colorbar('off');
    
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
    
%     %ÿ�λ������еĵ�
%     %scatter(X1,X2,Adjusted_Mut,'m');
%     scatter(X1,X2,Adjusted_Mut,Adjusted_Mut);
%     for i = 1:population
%         text(X1(i),X2(i),num2str(i),'Color','m');%��΢����,�������������С
%     end

    %ÿ��ֻ�����ھӵĵ�
    scatter( X1( 1:nbr ),X2( 1:nbr ),Mut_adjusted( 1:nbr ),'g' );
    
    %����
    for i = 1:nbr
        for j = i + 1:nbr%��Ϊ�˼��ǶԳƾ���
            if(adjacent_matrix(i,j))
                line([X1(i),X1(j)], [X2(i),X2(j)],'Color','y');
            end
        end
    end
    
    %���
    for i = 1:nbr
        text(X1(i),X2(i),num2str(i),'Color','m');%��΢����,�������������С
    end
    
    %���⡢ͼ����������
    title('�ڽӾ���','Color','m','FontSize',15,'FontWeight','Bold');
    xlabel('΢��λ��-SNP','Color','m','FontSize',10,'FontWeight','Bold');
    ylabel('΢��λ��-SNP','Color','m','FontSize',10,'FontWeight','Bold');
%      legend({'��Ӧ��','λ��','�ٶ�','��������','�ھ�����','��������'},...
%          'Location','eastoutside','Orientation','horizontal','FontSize',8,'FontWeight','Bold');
    legend({'λ��','�ڽӹ�ϵ'},...
         'Location','southoutside','Orientation','Horizental','FontSize',8,'FontWeight','Bold');
    hold off;
 
end

