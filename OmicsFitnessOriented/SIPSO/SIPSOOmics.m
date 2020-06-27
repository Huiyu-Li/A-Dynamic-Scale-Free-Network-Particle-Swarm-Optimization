function solution = SIPSOOmics(population, dimensions, iteration)
%  SIPSOOmics(100,2,100)
tic;
%% 整合数据实验
%保存位置前缀
SavePosition = 'E:\Operation\SIPSO\Integrated\';
%读入数据
input = load('E:\Data\integrative4.mat');
pts = input.data;%样本
class = input.label;%对照
FeatureName = input.featureName';%featurename
%%
% 求无标度网络结构
matrix = FreeScale2(population);
Net = full(matrix);
K = sum(Net);

%设置微粒的速度和位置范围
[~, SNP_n] = size(pts);%[行，列]或[sample feature]
xmax = SNP_n; %最大位置：SNP个数，
xmin = 1;     %最小位置
vmax = xmax - 1;  %最大速度
vmin = - vmax;%最小速度

%初始化基本参数
shrink = 0.72989;
c1 = 2.05;
c2 = 2.05;

Particle = struct('v',cell(1),'x',cell(1),...
    'mut',[],'pbest_x',cell(1),'pbest_mut',[],'nbest_x',cell(1),'nbest_mut',[]);

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
 [Particle.nbest_x] = deal([0,0]);%只赋一个值也没关系
 [Particle.nbest_mut] = deal(0);
%设置微粒的邻居最优
for i = 1:1:population
    n = find(Net(i,:) == 1);%找到邻接矩阵中邻居的索引，是一个行矩阵
    for j = 1:1:numel(n)
        if Particle(n(j)).pbest_mut > Particle(i).nbest_mut%个人最优大于邻居最优，更新邻居(其他微粒)的信息
            Particle(i).nbest_mut = Particle(n(j)).pbest_mut;
            Particle(i).nbest_x = Particle(n(j)).pbest_x;
        end
    end
end
%初始化结束
%开始进行迭代
for iter = 1:iteration  
    %更新微粒的速度
    for i = 1:1:population
        for j = 1:1:dimensions
            if K(i) <= 5
                Particle(i).v(j) = shrink * (Particle(i).v(j) + c1 * rand(1) * (Particle(i).pbest_x(j) - Particle(i).x(j)) ...
                + c2 * rand(1) * (Particle(i).nbest_x(j) - Particle(i).x(j)));
                Particle(i).v(j) = round(Particle(i).v(j));
            else
                temp = 0;
                n = find( Net(i,:) == 1);
                for l = 1:1:numel(n);
                    temp = temp + rand(1) * (c1 + c2) * (Particle(n(l)).pbest_x(j) - Particle(i).x(j));
                end
                Particle(i).v(j) = shrink * (Particle(i).v(j) + (1/numel(n)) * temp);
                Particle(i).v(j) = round(Particle(i).v(j));
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
    
    %更新微粒的邻居最优
    for i = 1:1:population
        n = find(Net(i,:) == 1);
        for j = 1:1:numel(n)
            if Particle(n(j)).pbest_mut > Particle(i).nbest_mut
                    Particle(i).nbest_mut = Particle(n(j)).pbest_mut;
                    Particle(i).nbest_x = Particle(n(j)).pbest_x;
            end
        end
    end
end
%迭代结束
%%
%寻找最终结果并保存
SavePosition = [SavePosition 'Solution.mat'];
FindSolution( Particle, population, FeatureName, SavePosition);

toc;
end