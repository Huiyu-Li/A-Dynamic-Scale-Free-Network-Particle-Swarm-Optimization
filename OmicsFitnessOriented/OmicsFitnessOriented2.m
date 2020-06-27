function OmicsFitnessOriented2(population, dimensions, iteration)
tic;
% OmicsFitnessOriented2(1000,2,100)
%数据来源
Data = 'E:\Data\integrative4.mat';
%保存位置前缀SavePosition = 'E:\MathConstructionExercise\实验次数\';
SavePosition = ['E:\Operation\'];
        
input = load(Data);
class = input.label;%对照
featureName = input.featureName';%转化成了列矩阵，特征名

%设置微粒速度和位置的范围
pts = input.data;%样本
[~, SNP_n] = size(pts);%样本行：sample个数，样本列：feature.分别返回其个数
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
Particle = struct('v',cell(1),'x',cell(1),...
    'mut',[],'pbest_x',cell(1),'pbest_mut',[],'nbest_x',cell(1),'nbest_mut',[]);
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
        Particle(i).x(j) = round(1 + rand(1) * (xmax - xmin) );
        %结果中有取到1的，也有取到100的
    end
   Particle(i).mut = MutualInformation(pts, class,Particle(i).x);%计算适应度
end

%初始化微粒的个人最优位置：等于微粒的初始化位置
[Particle.pbest_x] = Particle.x;
[Particle.pbest_mut] = Particle.mut;

%初始化微粒的最优邻居位置,必须得初始化，否则后面的初次赋值是失败的
%不知道能否找到更好的赋值方法，即为结构体的某一个字段赋同样的值
 [Particle.nbest_x] = deal(0);%只赋一个值也没关系
 [Particle.nbest_mut] = deal(0);
 
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
[~,id] = sort([Particle( m0 + 1:population ).mut],'descend');
id = id + m0;

%将选中的两个点与前两个交换位置（如果适应度不同的话）
for i = 1:m0
    if(Particle(id(i)).mut ~= Particle(i).mut)
        temp = Particle(id(i));
        Particle(id(i)) = Particle(i);
        Particle(i) = temp;
    end
end
%至此，还剩population - m0个点需要加入
%初始化结束

%一定到population次迭代的建图，iteration就是单纯的建完图后的迭代次数
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
    [~,id] = sort([Particle( 1:iter - 1 ).mut],'descend'); 
    choose( 1:m )= id( 1:m );%初始化选择矩阵
    
    %在邻接矩阵进中加入新边，邻接矩阵是一点一点扩大的。     
    for k = 1:m 
        adjacent_matrix(iter,choose(k)) = 1;         
        adjacent_matrix(choose(k),iter) = 1;     
    end 
    
    %更新微粒的速度
    %无邻居用集体最优|有邻居用邻居的个人历史最优
    %建图时，《=iter的有邻居
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
 
end          
%建图完毕

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
end          
%迭代结束

%寻找最终结果并保存\Solution.mat(Pbest.loc,feature，'align','iM','iP')
    SolutionPath = [SavePosition,'Solution.mat'];
    FindSolution( Particle, population, featureName,SolutionPath);
toc;
end
