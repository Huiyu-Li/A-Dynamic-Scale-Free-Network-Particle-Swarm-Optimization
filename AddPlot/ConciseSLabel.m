function ConciseSLabel( titleStr, Solution)
%   ConciseSLabel( titleStr, Solution )
%Ϊʲôͼ��������ʾʵ����ɫ��ֻ��ʾ��״��
%����ͼ�Ĵ�С��̫һ��
%������ɫ
%�ѵ���Ĵ�һ�����Ȧס����
%��̬���⣬��ȡû����һ�γ�һ��ͼ
%ֻ��һ��ͼ���൱�ڿ��ӻ����

%������ȡλ��
BackgroundDataPosition = 'E:\MathConstructionExercise\AttachedData\Background.mat';

    figure;%ÿ�����У����´�һ��ͼ�δ��ڣ���ֹ��ԭͼ���ػ滹���Ա���ԭͼ
    hold on;
    dot_a = 100;%scatter��������Ĵ�С
    
    %����������
    xmin = -10;xmax = 110;ymin = xmin;ymax = xmax;
    axis([xmin xmax ymin ymax]);%Ϊ�˿���Խ���ֵ
    axis square;
    %axis equal;
    %axis manual;
    
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
    
     n = 5;%���������ҪС�ڵ���Solution�н���ĸ���
     %�Ȼ����ٱ�ע����ֹ��ע������

     %Ԥ�ȷ����ڴ�
     LX(n) = 0;
     LY(n) = 0;
     
     %��ȡ����
     for i = 1:n
         LX(i) = Solution(i).p(1);%��Ҫ���㲢����ע��XY
         LY(i) = Solution(i).p(2);
     end
     
     %����
     scatter(LX,LY,dot_a,'sg','filled');
     
     %��ע
     %eg.text(2,8,'A Simple Plot','Color','red','FontSize',14)
     str3 = '';
     for i = 1:n
         str1 = ['S' num2str(i)];
         str2 = [str1 '[' num2str(LX(i)) ',' num2str(LY(i)) ']'];
         str3 = char(str3,str2);
         text(LX(i),LY(i),str1);
     end
       text(5,20,str3);%ͨ����ͼ��֪������ط���Ӧ�Ⱥܵ�
    
     %���⡢ͼ����������
     title(titleStr,'Color','b','FontSize',15,'FontWeight','Bold');
     xlabel('΢��λ��-SNP','Color','b','FontSize',10,'FontWeight','Bold');
     ylabel('΢��λ��-SNP','Color','b','FontSize',10,'FontWeight','Bold');
%      legend({'��Ӧ��','λ��','�ٶ�','��������','�ھ�����','��������'},...
%          'Location','eastoutside','Orientation','horizontal','FontSize',8,'FontWeight','Bold');
     %��ʼ������٣���ע�͵�������
     legend({'Solution'},...
         'Location','best','FontSize',8,'FontWeight','Bold');   
     hold off;
    
end
