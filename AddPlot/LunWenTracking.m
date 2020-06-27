function LunWenTracking( Particle, adjacent_matrix,population)
%   LunWenTracking( Particle, adjacent_matrix)

    figure;%每次运行，重新打开一个图形窗口，防止在原图上重绘还可以保留原图
    %没有坐标轴，没有图例，不用标号
    %控制坐标轴
    xmin = -10;xmax = 110;ymin = xmin;ymax = xmax;
    axis([xmin xmax ymin ymax]);%为了看到越界的值
    axis square;
  
    %axis equal;
    %axis manual;
    
    nbr = length(adjacent_matrix);%因为邻接矩阵是一点一点建起来的
    
    %预先分配内存
    X1(population) = 0;
    X2(population) = 0;
    NbestX1(population) = 0;
    NbestX2(population) = 0;
    for i = 1:population
        %位置
        X1(i) = Particle(i).x(1);
        X2(i) = Particle(i).x(2);
    end
        %邻居最优
        for i = 1:nbr%邻居关系是相互的，单独提取时因为邻居最优有空值时提取失败
            NbestX1(i) = Particle(i).nbest_x(1);
            NbestX2(i) = Particle(i).nbest_x(2);
            text(NbestX1(i),NbestX2(i),num2str(i),'Color','b');%标微粒号,还可以有字体大小
        end
        %邻居最优
        for i = 1:nbr%邻居关系是相互的，单独提取时因为邻居最优有空值时提取失败
            NbestX1(i) = Particle(i).nbest_x(1);
            NbestX2(i) = Particle(i).nbest_x(2);
%             text(NbestX1(i),NbestX2(i),num2str(i),'Color','b');%标微粒号,还可以有字体大小
        end

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

    %每次只画有邻居的点
    scatter( X1( 1:nbr ),X2( 1:nbr ),Mut_adjusted( 1:nbr ),'m' );
    
    %连线
    for i = 1:nbr
        for j = i + 1:nbr%因为人家是对称矩阵
            if(adjacent_matrix(i,j))
                line([X1(i),X1(j)], [X2(i),X2(j)],'Color','b');
            end
        end
    end
    
    %标号
    for i = 1:nbr
        text(X1(i),X2(i),num2str(i),'Color','y');%标微粒号,还可以有字体大小
    end
    axis off;
    hold off;
 
end

