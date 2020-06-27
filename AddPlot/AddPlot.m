function Solution = AddPlot(population, dimensions, iteration, data)
tic;
%   AddPlot(50,2,50,'E:\MathConstructionExercise\AttachedData\dat100.mat')
%一个警告也没有了，靓！

%在fitnessOriented的基础上，代码格式已优化（以后尝试模块化代码）
%五姐妹(AddPlot-InitializedTracking-Tracking-SolutionLabel|ConciseSLabel )

%主函数-数据保存，子函数-数据提取。记住这个分布方便修改
%保存位置前缀  E:\MathConstructionExercise\Operation\AddPlotOperation\ +自己的名字
SavePosition = 'E:\MathConstructionExercise\1';
%如果文件存在会被重写

%初始化开始
    %设置微粒速度和位置的范围
    input = load(data);
    pts = input.pts;%样本
    class = input.class;%对照
    [~, SNP_n] = size(pts);%样本行：sample个数，样本列：SNP.分别返回其个数
    xmax = SNP_n; %最大位置：SNP个数，eg.100
    xmin = 1;     %最小位置
    vmax = xmax - 1;  %最大速度99，
    vmin = - vmax;%最小速度-99，

    %初始化基本参数
    shrink = 0.72989;
    c1 = 2.05;
    c2 = 2.05;
    %计算动态惯性权重W所需要的参数
    a = 0.4;
    b = 0.9;
	n = iteration;
    %本次没有使用结构体内嵌，目前还不知道那种更方便一些
    Particle = struct('v',cell(1),...
                      'x',cell(1), 'mut',[],...
                      'pbest_x',cell(1),'pbest_mut',[],...
                      'nbest_x',cell(1),'nbest_mut',[]);
    %cell(1):1*1struct
    
    % 初始化微粒的速度：在定义域内取一个(整数)随机值
    for i = 1:1:population 
        for j = 1:1:dimensions
            Particle(i).v(j) = round(vmin + (vmax - vmin) * rand(1));
            %v{j}赋值结果是cell;v(j)赋值结果是数组
        end
    end
    
    %初始化微粒的位置：在定义域内取一个(整数)随机值
    for i = 1:1:population
        for j = 1:1:dimensions
            Particle(i).x(j) = round(1 + rand(1) * (xmax - 1) );
            %结果中有取到1的，也有取到100的
        end
       Particle(i).mut = MutualInformation(pts, class,Particle(i).x);%计算适应度
    end
    
    %初始化微粒的个人最优位置：等于微粒的初始化位置
    [Particle.pbest_x] = Particle.x;
    [Particle.pbest_mut] = Particle.mut;
    
    %初始化微粒的最优邻居位置,必须得初始化，否则后面的初次赋值是失败的
     %[Particle.nbest_x] = deal([0,0]);%只赋一个值也没关系
     [Particle.nbest_mut] = deal(0);%只将mut赋值为零值，因为位置赋值为0是bug
     
    %初始化微粒的集体最优位置(只有一个，从个人历史最优中找)
    [seq,id] = sort([Particle.pbest_mut],'descend');
    gbest_mut = seq(1);
    gbest_x = Particle(id(1)).pbest_x;
    
    %初始化无标度网络图
    m0 = 2;m = 2;
    % 初始化邻接矩阵，完全连通
    adjacent_matrix = ones( m0, m0);
    for i = 1:m0
        adjacent_matrix(i,i) = 0;
    end
    
    %从[m0 + 1,;population]中选择当前适应度最高的两个点,这样就不用处理交换紊乱了
    [~,id] = sort([Particle(m0 + 1:population).mut],'descend');%[m0 + 1:population]去掉了方括号，不知道对不对？
    id = id + m0;
    %将选中的两个点与前两个交换位置（如果适应度不同的话）
    for i = 1:m0
        if(Particle(id(i)).mut ~= Particle(i).mut)
            %肯定会有没有交换的，应该没什么影响吧，假使没有交换，是因为人家也是适应度最高的所以不用交换
            temp = Particle(id(i));
            Particle(id(i)) = Particle(i);
            Particle(i) = temp;
        end
    end
    %至此，还剩population - m0个点需要加入
%初始化结束

% %跟踪画图-初始化结束,这是一个初始化跟踪独用的函数
%     InitializedTracking( Particle, population, adjacent_matrix, gbest_x );
%     %保存绘图
%     name = [SavePosition '1InitializeTracking.png'];
%     saveas(gcf,name);%OK!
    
%迭代建图
    for iter = (m0+1):population
        
        %加点
        %从[iter,population]中选择当前适应度最高的一个微粒作为入图微粒
        [~,id] = sort([Particle( iter:population ).mut],'descend');
        id = id + (iter - 1);%注意id是从1开始的,加上(iter - 1)之后才和Particle中的下标相对应
        %将入图微粒与iter位置的微粒交换（原则上是不同的时候才交换）
        if(Particle(id(1)).mut ~= Particle(iter).mut)
            temp = Particle(id(1));
            Particle(id(1)) = Particle(iter);
            Particle(iter) = temp;
        end
        
        %从[1：iter - 1]中选择当前适应度最高的两个微粒作为邻居
        %其实这样挺好的，不存在重叠问题
        [~,id] = sort([Particle( 1:iter - 1 ).mut],'descend'); 
        choose( 1:m )= id( 1:m );%初始化选择矩阵
        %总是找当前适应度最高的微粒，是否会更容易陷入局部最优？
        %又怎样去判断是不是陷入了局部最优呢？能不能用图直观地看一下？
        
        %在邻接矩阵进中加入新边，邻接矩阵是一点一点扩大的。     
        for k = 1:m 
            adjacent_matrix(iter,choose(k)) = 1;         
            adjacent_matrix(choose(k),iter) = 1;     
        end 
        
        %更新微粒的速度
        %无邻居用集体最优|有邻居用邻居的个人历史最优
        %建图时，<=iter的有邻居
        for i = 1:iter%有邻居
            nbr = find(adjacent_matrix(i,:) == 1);
            for j = 1:1:dimensions
                 temp = 0;
                for k = 1:numel(nbr)
                    temp = temp + rand(1) * (c1 + c2) * (Particle(nbr(k)).pbest_x(j) - Particle(i).x(j));
                end
                    Particle(i).v(j) = shrink * (Particle(i).v(j) + (1/numel(nbr)) * temp);
                    Particle(i).v(j) = round( Particle(i).v(j) );
            end
        end
        for i = iter + 1:population%无邻居
            for j = 1:1:dimensions
                Particle(i).v(j) = (b - iter*(b - a)/n) * Particle(i).v(j) +...
                    c1 * rand(1) * (Particle(i).pbest_x(j) - Particle(i).x(j)) + ...
                    c2 * rand(1) * (gbest_x(j) - Particle(i).x(j));
                Particle(i).v(j) = round(Particle(i).v(j));
            end
        end
        
        %更新微粒的位置
        for i = 1:1:population
            for j = 1:1:dimensions
                Particle(i).x(j) = Particle(i).x(j) + Particle(i).v(j);
                if Particle(i).x(j) < xmin || Particle(i).x(j) > xmax
                    Particle(i).x(j) = xmin + round( ( xmax  - xmin) * rand(1) );
                end 
            end
           Particle(i).mut = MutualInformation(pts, class,Particle(i).x);
        end 
        
        %更新微粒的个人最优位置
        for i = 1:1:population
            if Particle(i).mut > Particle(i).pbest_mut
               Particle(i).pbest_mut = Particle(i).mut;
               Particle(i).pbest_x = Particle(i).x;
            end
        end
        
        %更新微粒的最优邻居位置（对于有邻居的来说）
        for i = 1:1:iter
             nbr = find(adjacent_matrix(i,:) == 1);
            for j = 1:1:numel(nbr)
                if Particle(nbr(j)).pbest_mut > Particle(i).nbest_mut
                    Particle(i).nbest_mut = Particle(nbr(j)).pbest_mut;
                    Particle(i).nbest_x = Particle(nbr(j)).pbest_x;
                end
            end
        end
        
        %更新集体最优
        [seq,id] = sort([Particle.pbest_mut],'descend');
        if(seq(1) > gbest_mut)
            gbest_mut = seq(1);
            gbest_x = Particle(id(1)).pbest_x;
        end   
        
%跟踪画图-建图过程
    %图示和入图的微粒个数相对应
    %如果每种跟踪只画一个图，就把函数调用语句放到end后面
     LunWenTracking( Particle, adjacent_matrix,population);
%     Tracking( Particle, population, adjacent_matrix, gbest_x, '建图跟踪',iter );
    %保存绘图
    gname = [SavePosition 'DrawingTraking',num2str(iter),'.png'];%OK!
    saveas(gcf,gname);
    
%     %图示和建图迭代次数数相对应
%     Tracking( Particle, population, adjacent_matrix, gbest_x, '建图跟踪',iter );

    end          
%建图完毕

%寻找中间结果并保存
    SolutionN = 5;%寻找前五个解决方案
    Pbest_mut_sorted_name = 'IntermediatePbest_mut_sorted.mat';
    Pbest_x_sorted_name = 'IntermediatePbest_x_sorted.mat';
    Solution_name = 'IntermediateS.mat';
    IntermediateS = FindSolution( Particle, population, SolutionN, SavePosition,...
    Pbest_mut_sorted_name, Pbest_x_sorted_name, Solution_name);

%中间结果绘图并保存
    DrawingName = '中间解决方案';
    DetailedSLabel_name = 'IntermediateDetailedSLabel.png'; 
    ConciseSLabel_name = 'IntermediateConciseSLabel.png';
    DrawingSolutin( Particle, population, adjacent_matrix, gbest_x, IntermediateS, DrawingName,...
    SavePosition, DetailedSLabel_name, ConciseSLabel_name);


%开始建图后的迭代
    D = sum(adjacent_matrix);%微粒的深度矩阵
    for iter = 1:1:iteration
        
        %更新微粒的速度
        for i = 1:1:population
            if D(i) <= 5 %K表示微粒的深度，行矩阵
                for j = 1:1:dimensions
                    Particle(i).v(j) = shrink * (Particle(i).v(j) + c1 * rand(1) * (Particle(i).pbest_x(j) - Particle(i).x(j))+...
                        c2 * rand(1) * (Particle(i).nbest_x(j) - Particle(i).x(j)));
                    Particle(i).v(j) = round(Particle(i).v(j)); 
                end
            else
                 nbr = find(adjacent_matrix(i,:) == 1);
                for j = 1:1:dimensions
                    temp = 0;
                        for k = 1:numel(nbr) 
                            temp = temp + rand(1) * (c1 + c2) * (Particle(nbr(k)).pbest_x(j) - Particle(i).x(j));
                        end
                     Particle(i).v(j) = shrink * (Particle(i).v(j) + (1/numel(nbr)) * temp);
                     Particle(i).v(j) = round( Particle(i).v(j) );
                end
            end
        end
        
        %更新微粒的位置
        for i = 1:1:population
            for j = 1:1:dimensions
                Particle(i).x(j) =  Particle(i).x(j) +  Particle(i).v(j);
                if  Particle(i).x(j) < xmin ||  Particle(i).x(j) > xmax
                     Particle(i).x(j) = xmin + round( ( xmax  - xmin) * rand(1) );
                end 
            end
             Particle(i).mut = MutualInformation(pts, class, Particle(i).x);
        end
        
        %更新微粒的个人最优位置
        for i = 1:1:population
            for j = 1:1:dimensions
                if  Particle(i).mut >  Particle(i).pbest_mut
                     Particle(i).pbest_mut =  Particle(i).mut;
                     Particle(i).pbest_x =  Particle(i).x;
                end
            end
        end
        
        %更新微粒的邻居最优位置
        for i = 1:1:population
            nbr = find(adjacent_matrix(i,:) == 1);
            for j = 1:1:numel(nbr)
                if  Particle(nbr(j)).pbest_mut > Particle(i).nbest_mut
                    Particle(i).nbest_mut = Particle(nbr(j)).pbest_mut;
                    Particle(i).nbest_x = Particle(nbr(j)).pbest_x;
                end
            end
        end
        
        %更新集体最优(这是为了画图而添加的，实际运算时因为图已经建完，故不再用pbest更新速度了)
        [seq,id] = sort([Particle.pbest_mut],'descend');
        if(seq(1) > gbest_mut)
            gbest_mut = seq(1);
            gbest_x = Particle(id(1)).pbest_x;
        end           
        
%跟踪画图-建图后迭代
    %如果每种跟踪只画一个图，就把函数调用语句放到end后面
    Tracking( Particle, population, adjacent_matrix, gbest_x, '迭代跟踪',iter );
    %保存绘图
    gname = [SavePosition 'IterationTraking',num2str(iter),'.png'];%OK!
    saveas(gcf,gname);
    
    end          
%迭代结束

%寻找最终结果并保存
    SolutionN = 5;%寻找前五个解决方案
    Pbest_mut_sorted_name = 'SolutionPbest_mut_sorted.mat';
    Pbest_x_sorted_name = 'SolutionPbest_x_sorted.mat';
    Solution_name = 'Solution.mat';
    Solution = FindSolution( Particle, population, SolutionN, SavePosition,...
    Pbest_mut_sorted_name, Pbest_x_sorted_name, Solution_name);

%中间结果绘图并保存
    %在这里我为了看最详尽的全程，我增加了对pbest的更新，
    %所以，这里我们可以统一绘图并保存
    DrawingName = '最终解决方案';
    DetailedSLabel_name = 'SolutionDetailedSLabel.png'; 
    ConciseSLabel_name = 'SolutionConciseSLabel.png';
    DrawingSolutin( Particle, population, adjacent_matrix, gbest_x, IntermediateS, DrawingName,...
    SavePosition, DetailedSLabel_name, ConciseSLabel_name);
  toc;%单位是秒，/60是分钟 
  %时间已过 1138.250616 秒。 = 18.9708436分钟
  
end