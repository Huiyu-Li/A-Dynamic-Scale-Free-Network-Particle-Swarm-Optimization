function ConciseSLabel( titleStr, Solution)
%   ConciseSLabel( titleStr, Solution )
%为什么图例不能显示实际颜色？只显示形状？
%两个图的大小不太一样
%整体颜色
%把点调的大一点可以圈住数字
%动态标题，争取没迭代一次出一个图
%只画一个图，相当于可视化结果

%数据提取位置
BackgroundDataPosition = 'E:\MathConstructionExercise\AttachedData\Background.mat';

    figure;%每次运行，重新打开一个图形窗口，防止在原图上重绘还可以保留原图
    hold on;
    dot_a = 100;%scatter中所画点的大小
    
    %控制坐标轴
    xmin = -10;xmax = 110;ymin = xmin;ymax = xmax;
    axis([xmin xmax ymin ymax]);%为了看到越界的值
    axis square;
    %axis equal;
    %axis manual;
    
    %如果不画图底请将其注释掉
    %适应度图底（必须是2*2矩阵，行列id是位置，内容是mut）
    BgData = load(BackgroundDataPosition);
    BX = BgData.Background.X;
    BY = BgData.Background.Y;
    BZ = BgData.Background.Z;
    contour(BX,BY,BZ,5);
    %设置colormap(仅设一次即可)
    colormap cool;%colormap与figure对应，在这里我们两个图的map一样，设一次就可
    %设置colorbar
    BgCbarTicks = linspace(-0.07,0.2,6);
    %因为Mut_min = [-0.0595209048640656];Mut_max = [0.121407472729296];
    %这里我们生成6个线性分布向量
    colorbar('Ticks',BgCbarTicks);%一个图一个colorbar
    
     n = 5;%标记数量，要小于等于Solution中结果的个数
     %先画点再标注，防止标注被覆盖

     %预先分配内存
     LX(n) = 0;
     LY(n) = 0;
     
     %提取数据
     for i = 1:n
         LX(i) = Solution(i).p(1);%需要画点并做标注的XY
         LY(i) = Solution(i).p(2);
     end
     
     %画点
     scatter(LX,LY,dot_a,'sg','filled');
     
     %标注
     %eg.text(2,8,'A Simple Plot','Color','red','FontSize',14)
     str3 = '';
     for i = 1:n
         str1 = ['S' num2str(i)];
         str2 = [str1 '[' num2str(LX(i)) ',' num2str(LY(i)) ']'];
         str3 = char(str3,str2);
         text(LX(i),LY(i),str1);
     end
       text(5,20,str3);%通过看图可知，这个地方适应度很低
    
     %标题、图例、坐标轴
     title(titleStr,'Color','b','FontSize',15,'FontWeight','Bold');
     xlabel('微粒位置-SNP','Color','b','FontSize',10,'FontWeight','Bold');
     ylabel('微粒位置-SNP','Color','b','FontSize',10,'FontWeight','Bold');
%      legend({'适应度','位置','速度','个人最优','邻居最优','集体最优'},...
%          'Location','eastoutside','Orientation','horizontal','FontSize',8,'FontWeight','Bold');
     %初始化后跟踪，请注释掉这块代码
     legend({'Solution'},...
         'Location','best','FontSize',8,'FontWeight','Bold');   
     hold off;
    
end
