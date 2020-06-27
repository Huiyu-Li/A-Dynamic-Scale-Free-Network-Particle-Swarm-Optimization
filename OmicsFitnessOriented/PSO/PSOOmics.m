function Solution = PSOOmics(population, dimensions, iteration)
tic;
% PSOOmics(100,2,100)
% %% 分块数据实验[CN GE ME]
% %保存位置前缀
% SavePosition = 'E:\Operation\Block\HNSC_ME';
% %读入数据
% input = load('E:\TCGA2\Block\HNSC.mat');
% pts = input.ME;%样本
% class = input.Lable;%对照
% FeatureName = input.MEFeatureName;
%% 整合数据实验
%保存位置前缀
SavePosition = 'E:\Operation\PSO\Integrated\';
%读入数据
input = load('E:\Data\integrative4.mat');
pts = input.data;%样本
class = input.label;%对照
FeatureName = input.featureName';%featurename
%%
%设置微粒的速度和位置范围
[~, SNP_n] = size(pts);%[行，列]或[sample feature]
xmax = SNP_n; %最大位置：SNP个数，
xmin = 1;     %最小位置
vmax = xmax - 1;  %最大速度
vmin = - vmax;%最小速度
%%
%初始化基本参数
shrink = 0.72989;
c1 = 2.05;
c2 = 2.05;
%计算动态惯性权重W所需要的参数
a = 0.4;
b = 0.9;
n = iteration;

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
 
%初始化微粒的集体最优位置(只有一个，从个人历史最优中找)
[seq,id] = sort([Particle.pbest_mut],'descend');
gbest_mut = seq(1);
gbest_x = Particle(id(1)).pbest_x;
%初始化结束
%% 开始迭代
for iter = 1:iteration    
    %更新微粒的速度
    for i = 1:1:population
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
    %更新微粒的集体最优(只有一个，从个人历史最优中找)
    [seq,id] = sort([Particle.pbest_mut],'descend');
    gbest_mut = seq(1);
    gbest_x = Particle(id(1)).pbest_x;
end          
%迭代结束
%%
%寻找最终结果并保存
SavePosition = [SavePosition 'Solution.mat'];
FindSolution( Particle, population, FeatureName, SavePosition);

toc;
end