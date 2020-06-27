function Solution = PSOOmics(population, dimensions, iteration)
tic;
% PSOOmics(100,2,100)
% %% �ֿ�����ʵ��[CN GE ME]
% %����λ��ǰ׺
% SavePosition = 'E:\Operation\Block\HNSC_ME';
% %��������
% input = load('E:\TCGA2\Block\HNSC.mat');
% pts = input.ME;%����
% class = input.Lable;%����
% FeatureName = input.MEFeatureName;
%% ��������ʵ��
%����λ��ǰ׺
SavePosition = 'E:\Operation\PSO\Integrated\';
%��������
input = load('E:\Data\integrative4.mat');
pts = input.data;%����
class = input.label;%����
FeatureName = input.featureName';%featurename
%%
%����΢�����ٶȺ�λ�÷�Χ
[~, SNP_n] = size(pts);%[�У���]��[sample feature]
xmax = SNP_n; %���λ�ã�SNP������
xmin = 1;     %��Сλ��
vmax = xmax - 1;  %����ٶ�
vmin = - vmax;%��С�ٶ�
%%
%��ʼ����������
shrink = 0.72989;
c1 = 2.05;
c2 = 2.05;
%���㶯̬����Ȩ��W����Ҫ�Ĳ���
a = 0.4;
b = 0.9;
n = iteration;

Particle = struct('v',cell(1),'x',cell(1),...
    'mut',[],'pbest_x',cell(1),'pbest_mut',[],'nbest_x',cell(1),'nbest_mut',[]);

% ��ʼ��΢�����ٶȣ��ڶ�������ȡһ��(����)���ֵ
for i = 1:1:population 
    for j = 1:1:dimensions
        Particle(i).v(j) = round(vmin + (vmax - vmin) * rand(1));
        %v{j}��ֵ�����cell;v(j)��ֵ���������
    end
end

%��ʼ��΢����λ�ã��ڶ�������ȡһ��(����)���ֵ
for i = 1:1:population
    for j = 1:1:dimensions
        Particle(i).x(j) = round(1 + rand(1) * (xmax - xmin) );
        %�������ȡ��1�ģ�Ҳ��ȡ��100��
    end
   Particle(i).mut = MutualInformation(pts, class,Particle(i).x);%������Ӧ��
end

%��ʼ��΢���ĸ�������λ�ã�����΢���ĳ�ʼ��λ��
[Particle.pbest_x] = Particle.x;
[Particle.pbest_mut] = Particle.mut;
 
%��ʼ��΢���ļ�������λ��(ֻ��һ�����Ӹ�����ʷ��������)
[seq,id] = sort([Particle.pbest_mut],'descend');
gbest_mut = seq(1);
gbest_x = Particle(id(1)).pbest_x;
%��ʼ������
%% ��ʼ����
for iter = 1:iteration    
    %����΢�����ٶ�
    for i = 1:1:population
        for j = 1:1:dimensions
            Particle(i).v(j) = (b - iter*(b - a)/n) * Particle(i).v(j) +...
                c1 * rand(1) * (Particle(i).pbest_x(j) - Particle(i).x(j)) + ...
                c2 * rand(1) * (gbest_x(j) - Particle(i).x(j));
            Particle(i).v(j) = round(Particle(i).v(j));
        end
    end
    
    %����΢����λ��
    for i = 1:1:population
        for j = 1:1:dimensions
            Particle(i).x(j) =  Particle(i).x(j) +  Particle(i).v(j);
            if  Particle(i).x(j) < xmin ||  Particle(i).x(j) > xmax
                 Particle(i).x(j) = xmin + round( ( xmax  - xmin) * rand(1) );
            end 
        end
         Particle(i).mut = MutualInformation(pts, class, Particle(i).x);
    end
    
    %����΢���ĸ�������λ��
    for i = 1:1:population
        for j = 1:1:dimensions
            if  Particle(i).mut >  Particle(i).pbest_mut
                 Particle(i).pbest_mut =  Particle(i).mut;
                 Particle(i).pbest_x =  Particle(i).x;
            end
        end
    end
    %����΢���ļ�������(ֻ��һ�����Ӹ�����ʷ��������)
    [seq,id] = sort([Particle.pbest_mut],'descend');
    gbest_mut = seq(1);
    gbest_x = Particle(id(1)).pbest_x;
end          
%��������
%%
%Ѱ�����ս��������
SavePosition = [SavePosition 'Solution.mat'];
FindSolution( Particle, population, FeatureName, SavePosition);

toc;
end