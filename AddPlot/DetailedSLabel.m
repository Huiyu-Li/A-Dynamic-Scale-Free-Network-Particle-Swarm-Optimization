function DetailedSLabel( Particle, population, adjacent_matrix, gbest_x, Solution, DrawingName )
%   DetailedSLabel( Particle, population, adjacent_matrix, gbest_x, Solution, DrawingName )
%在两个图上对结果都进行标记
%为什么图例不能显示实际颜色？只显示形状？
%两个图的大小不太一样
%整体颜色
%把点调的大一点可以圈住数字
%动态标题

%数据提取位置
BackgroundDataPosition = 'E:\MathConstructionExercise\AttachedData\Background.mat';

    figure;%每次运行，重新打开一个图形窗口，防止在原图上重绘还可以保留原图
    dot_a = 100;%scatter中所画点的大小，dot's area
    
%画第一个图
    subplot(1,2,1);
    hold on;
    
    %控制坐标轴
    xmin = -10;xmax = 110;ymin = xmin;ymax = xmax;
    axis([xmin xmax ymin ymax]);%为了看到越界的值
    axis square;
    %axis equal;
    %axis manual;
   
    %提取数据
    nbr = length(adjacent_matrix);%因为邻接矩阵是一点一点建起来的
    
    %预先分配内存
    X1(population) = 0;
    X2(population) = 0;
    V1(population) = 0;
    V2(population) = 0;
    PbestX1(population) = 0;
    PbestX2(population) = 0;
    NbestX1(population) = 0;
    NbestX2(population) = 0;
    
    for i = 1:population
        %位置
        X1(i) = Particle(i).x(1);
        X2(i) = Particle(i).x(2);
        text(X1(i),X2(i),num2str(i),'Color','m');%标微粒号,还可以有字体大小
        %速度
        V1(i) = Particle(i).v(1);
        V2(i) = Particle(i).v(2);
        %个人最优
        PbestX1(i) = Particle(i).pbest_x(1);
        PbestX2(i) = Particle(i).pbest_x(2);
        text(PbestX1(i),PbestX2(i),num2str(i),'Color','g');%标微粒号,还可以有字体大小
    end
        %邻居最优
        for i = 1:nbr%邻居关系是相互的，单独提取时因为邻居最优有空值时提取失败
            NbestX1(i) = Particle(i).nbest_x(1);
            NbestX2(i) = Particle(i).nbest_x(2);
            text(NbestX1(i),NbestX2(i),num2str(i),'Color','b');%标微粒号,还可以有字体大小
        end

        %集体最优，人家本来就是一个数组，无需提取
      
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
    
    %位置 圆 洋红m
    scatter(X1,X2,dot_a,'m');
    
    %速度 quiver(x y u v)
    quiver(X1,X2,V1,V2,'Color','m');
    
    %个人最优 方形s 绿g
    scatter(PbestX1,PbestX2,dot_a,'sg');
    
    %邻居最优
    scatter(NbestX1,NbestX2,dot_a,'db');
    
    %集体最优 星p 红r
    scatter(gbest_x(1),gbest_x(2),dot_a,'pr');
     
    %标记结果
    %eg.text(2,8,'A Simple Plot','Color','red','FontSize',14)
    n = 5;%标记数量
    str3 = '';
    
    %预先分配内存
    SX(n) = 0;
    SY(n) = 0;
    
    for i = 1:n
        SX(i) = Solution(i).p(1);%Solution中的XY
        SY(i) = Solution(i).p(2);
        str1 = ['S' num2str(i)];
        str2 = [str1 '[' num2str(SX(i)) ',' num2str(SY(i)) ']'];
        str3 = char(str3,str2);
        text(SX,SY,str1);
    end
    text(5,20,str3);%通过看图可知，这个地方适应度很低        
   
    %标题、图例、坐标轴
    title(DrawingName,'Color','m','FontSize',15,'FontWeight','Bold');
    xlabel('微粒位置-SNP','Color','m','FontSize',10,'FontWeight','Bold');
    ylabel('微粒位置-SNP','Color','m','FontSize',10,'FontWeight','Bold');
%      legend({'适应度','位置','速度','个人最优','邻居最优','集体最优'},...
%          'Location','eastoutside','Orientation','horizontal','FontSize',8,'FontWeight','Bold');
     %初始化后跟踪，请注释掉这块代码
    legend({'适应度','位置','速度','个人','邻居','集体'},...
         'Location','southoutside','Orientation','Horizental','FontSize',8,'FontWeight','Bold');   
    hold off;
    
%画邻接矩阵
    subplot(1,2,2);
    hold on;
    
    %控制坐标轴
    axis([xmin xmax ymin ymax]);
    axis square;
%     axis equal;
%     axis manual;
    %根据位置画具有大小的微粒 %要是画不成功就用图底%不明显，再加个图底吧%给点加color矩阵
    
    %如果不画图底请将其注释掉
    contour(BX,BY,BZ,5);    
    %设置colorbar
    colorbar('Ticks',BgCbarTicks);%一个图一个colorbar
    caxis manual;%固定颜色设置，并应用于hold on之后的绘图中
    %colorbar('off');
    %奇了怪了，为什么debug和实际运行结果不一样？
    
    %为邻接矩阵中点的大小-适应度 做准备
    Mut = [Particle.mut];
    Mmax = max(Mut);
    Mmin = min(Mut);
    difference = Mmax - Mmin;
    Mut_norm = (Mut - Mmin)/difference;
    %目标区间[100,300]-[a,b] [mul,add]-[(b - a),a]
    %目的是让邻接矩阵中点的大小表征适应度，
    %你可以在保证点的大小合适的情况下尽量拉开差别
    %在这里进行乘法调整，减小后面的计算复杂度
    mul = 200;add = 100;
    Mut_adjusted = round(Mut_norm*mul + add);

    %画解决方案点
    scatter(SX,SY,dot_a,'sg','filled');

    %画邻接矩阵点
    scatter( X1( 1:nbr ),X2( 1:nbr ),Mut_adjusted( 1:nbr ),'g');
    
%      %标记结果，如果单步跟踪放在这里很好，但是想看最终结果放在这里并不好
%      %想看最终结果，想看谁尽量最后画谁
%      %eg.text(2,8,'A Simple Plot','Color','red','FontSize',14)
%      n = 5;%标记个数
%      for i = 1:n
%          x = Solution(i).p(1);
%          y = Solution(i).p(2);
%          str = ['S' num2str(i)];
%          text(x,y,str);
%      end
    
    %连线
    for i = 1:nbr
        for j = i + 1:nbr%因为人家是对称矩阵
            if(adjacent_matrix(i,j))
                line([X1(i),X1(j)], [X2(i),X2(j)],'Color','y');
            end
        end
    end
    
    for i = 1:nbr
        text(X1(i),X2(i),num2str(i),'Color','m');%标微粒号,还可以有字体大小
    end
    
    %标记
    %eg.text(2,8,'A Simple Plot','Color','red','FontSize',14)
    n = 5;%标记个数
    for i = 1:n
        x = Solution(i).p(1);
        y = Solution(i).p(2);
        str = ['S' num2str(i)];
        text(x,y,str);
    end
    
    %标题、图例、坐标轴
    title('邻接矩阵','Color','b','FontSize',15,'FontWeight','Bold');
    xlabel('微粒位置-SNP','Color','b','FontSize',10,'FontWeight','Bold');
    ylabel('微粒位置-SNP','Color','b','FontSize',10,'FontWeight','Bold');
%      legend({'适应度','位置','速度','个人最优','邻居最优','集体最优'},...
%          'Location','eastoutside','Orientation','horizontal','FontSize',8,'FontWeight','Bold');
    legend({'位置','邻接关系'},...
         'Location','southoutside','Orientation','Horizental','FontSize',8,'FontWeight','Bold');
     hold off;
 
end

      

