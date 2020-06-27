function InitializedTracking( Particle, population, adjacent_matrix, gbest_x )
%为什么图例不能显示实际颜色？只显示形状？
%两个图的大小不太一样,因为颜色条？
%适应度图底不理想
%颜色:红、洋红、绿、蓝、青c、黄、黑k
%把点调的大一点可以圈住数字
%邻接矩阵可以每次画出所有的点，也可以每次只画有邻居的点
%图像保存成png的好像还可以，但到底哪种最好呢？
%两个图数据一样，colorbar却有问题，真实见鬼！debug的时候也不出问题！？

% InitializedTracking( Particle, population, adjacent_matrix, gbest_x )
%为初始化后跟踪绘图专门建的函数

%数据提取位置
BackgroundDataPosition = 'E:\MathConstructionExercise\AttachedData\Background.mat';

    figure;%每次运行，重新打开一个图形窗口，防止在原图上重绘还可以保留原图
    dot_a = 100;%scatter中所画点的大小
    
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
    %关键是把结构体某个字段的数据转化成矩阵的形式，除了循环我还没有想到其他形式？
    nbr = length(adjacent_matrix);%因为邻接矩阵是一点一点建起来的
    
    %预先分配内存
    X1(population) = 0;
    X2(population) = 0;
    V1(population) = 0;
    V2(population) = 0;
    PbestX1(population) = 0;
    PbestX2(population) = 0;
    
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
        %初始化后的跟踪图，这里会覆盖前面的数字
    end
        %邻居最优，初始化后所有的邻居最优都是空值
        %集体最优，人家本来就是一个数组，无需提取
        
    %如果不画图底请将其注释掉
    %适应度图底（必须是2*2矩阵，行列id是位置，内容是mut）
    BgData = load(BackgroundDataPosition);%不知道这样是否可以,可以
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
    %scatter中默认圆形，无需也不能指明圆形
    scatter(X1,X2,dot_a,'m');
    
    %速度 quiver(x y u v)
    quiver(X1,X2,V1,V2,'Color','m');
    
    %个人最优 方形s 蓝g
    scatter(PbestX1,PbestX2,dot_a,'sg');
    
    %邻居最优（无） 菱形d 绿b
    
    %集体最优 星p 红r
     scatter(gbest_x(1),gbest_x(2),dot_a,'pr');
    
    %标题、图例、坐标轴
    title('初始化跟踪','Color','b','FontSize',15,'FontWeight','Bold');
    xlabel('微粒位置-SNP','Color','b','FontSize',10,'FontWeight','Bold');
    ylabel('微粒位置-SNP','Color','b','FontSize',10,'FontWeight','Bold');
    legend({'适应度','位置','速度','个人','集体'},...
         'Location','southoutside','Orientation','Horizental','FontSize',8,'FontWeight','Bold');
    hold off;
    
%画邻接矩阵
    subplot(1,2,2);
    hold on;%其作用范围为一个子图
    
    %控制坐标轴
    axis([xmin xmax ymin ymax]);
    axis square;
    %axis equal;
    %axis manual;
    %根据位置画具有大小的微粒 %要是画不成功就用图底%不明显，再加个图底吧%给点加color矩阵
    
    %如果不画图底请将其注释掉
    contour(BX,BY,BZ,5);    
    %设置colorbar
    colorbar('Ticks',BgCbarTicks);%一个图一个colorbar
    caxis manual;%固定颜色设置，并应用于hold on之后的绘图中
    %colorbar('off');
    %奇了怪了，为什么debug和实际运行结果不一样？
    
    %为邻接矩阵中 点的大小-适应度 做准备
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
    
%     %每次画出所有的点
%     %scatter(X1,X2,Adjusted_Mut,'m');
%     scatter(X1,X2,Adjusted_Mut,Adjusted_Mut);
%     for i = 1:population
%         text(X1(i),X2(i),num2str(i),'Color','m');%标微粒号,还可以有字体大小
%     end

    %每次只画有邻居的点
%     scatter( X1( [1:nbr] ),X2( [1:nbr] ),Mut_adjusted( [1:nbr] ),Mut_norm( [1:nbr] ));
%     []是可以去掉的
    scatter( X1( 1:nbr ),X2( 1:nbr ),Mut_adjusted( 1:nbr ),'m');
    %只要大小不要颜色了，因为MATLAB太智能，会根据颜色当前需要来调整colorbar，我用了caxis munual还是无济于事
    
    %连线
    for i = 1:nbr
        for j = i + 1:nbr%因为人家是对称矩阵
            if(adjacent_matrix(i,j))
                line( [X1(i),X1(j)], [X2(i),X2(j)],'Color','y');%注意写法，你的X1代表x,X2d代表y
            end
        end
    end
    
    %标号
    for i = 1:nbr
        text(X1(i),X2(i),num2str(i),'Color','m');%标微粒号,还可以有字体大小
    end
    
    %标题、图例、坐标轴
    title('邻接矩阵','Color','m','FontSize',15,'FontWeight','Bold');
    xlabel('微粒位置-SNP','Color','m','FontSize',10,'FontWeight','Bold');
    ylabel('微粒位置-SNP','Color','m','FontSize',10,'FontWeight','Bold');
    legend({'位置','邻接关系'},...
         'Location','southoutside','Orientation','Horizental','FontSize',8,'FontWeight','Bold');
    hold off;
 
end