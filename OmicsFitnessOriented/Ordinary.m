function Ordinary(population, dimensions, iteration, experiment)
tic;
%普通版微粒群，用于实验比较
% Ordinary(50,1,50,1)
%包括了寻找结果、去重、比对、保存

%紧扣特征选择，使用一阶的。demensions = 1;
%数据来源
Data = 'E:\MathConstructionExercise\AttachedData\integrative5.mat';
%保存位置前缀SavePosition = 'E:\MathConstructionExercise\实验次数\';
SavePosition = ['E:\MathConstructionExercise\',num2str(experiment),'\'];
%比对数据来源
PaperProvided = 'E:\MathConstructionExercise\AttachedData\standardFeature.mat';
        
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
% shrink = 0.72989;
c1 = 2.05;
c2 = 2.05;

%计算动态惯性权重W所需要的参数
a = 0.4;
b = 0.9;
n = iteration;

%本次没有使用结构体内嵌，目前还不知道那种更方便一些
Particle = struct('v',cell(1),'x',cell(1),...
    'mut',[],'pbest_x',cell(1),'pbest_mut',[]);
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
 
%初始化微粒的集体最优位置(只有一个，从个人历史最优中找)
[seq,id] = sort([Particle.pbest_mut],'descend');
gbest_mut = seq(1);
gbest_x = Particle(id(1)).pbest_x;
%初始化结束

for iter = 1:iteration
    %更新微粒的速度
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
    
    %更新集体最优
    [seq,id] = sort([Particle.pbest_mut],'descend');
    if(seq(1) > gbest_mut)
        gbest_mut = seq(1);
        gbest_x = Particle(id(1)).pbest_x;
    end 
 
end          

%寻找最终结果并保存\Solution.mat(Pbest.loc,feature，'align','iM','iP')
    SolutionPath = [SavePosition,'Solution.mat'];
    FindSolution( Particle, population, featureName,SolutionPath,PaperProvided);
toc;
end
