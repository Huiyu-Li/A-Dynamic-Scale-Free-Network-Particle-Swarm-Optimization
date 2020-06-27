function solution = SIPSOOmics(population, dimensions, iteration)
%  SIPSOOmics(100,2,100)
tic;
%% ��������ʵ��
%����λ��ǰ׺
SavePosition = 'E:\Operation\SIPSO\Integrated\';
%��������
input = load('E:\Data\integrative4.mat');
pts = input.data;%����
class = input.label;%����
FeatureName = input.featureName';%featurename
%%
% ���ޱ������ṹ
matrix = FreeScale2(population);
Net = full(matrix);
K = sum(Net);

%����΢�����ٶȺ�λ�÷�Χ
[~, SNP_n] = size(pts);%[�У���]��[sample feature]
xmax = SNP_n; %���λ�ã�SNP������
xmin = 1;     %��Сλ��
vmax = xmax - 1;  %����ٶ�
vmin = - vmax;%��С�ٶ�

%��ʼ����������
shrink = 0.72989;
c1 = 2.05;
c2 = 2.05;

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

%��ʼ��΢���������ھ�λ��,����ó�ʼ�����������ĳ��θ�ֵ��ʧ�ܵ�
 [Particle.nbest_x] = deal([0,0]);%ֻ��һ��ֵҲû��ϵ
 [Particle.nbest_mut] = deal(0);
%����΢�����ھ�����
for i = 1:1:population
    n = find(Net(i,:) == 1);%�ҵ��ڽӾ������ھӵ���������һ���о���
    for j = 1:1:numel(n)
        if Particle(n(j)).pbest_mut > Particle(i).nbest_mut%�������Ŵ����ھ����ţ������ھ�(����΢��)����Ϣ
            Particle(i).nbest_mut = Particle(n(j)).pbest_mut;
            Particle(i).nbest_x = Particle(n(j)).pbest_x;
        end
    end
end
%��ʼ������
%��ʼ���е���
for iter = 1:iteration  
    %����΢�����ٶ�
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
    
    %����΢�����ھ�����
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
%��������
%%
%Ѱ�����ս��������
SavePosition = [SavePosition 'Solution.mat'];
FindSolution( Particle, population, FeatureName, SavePosition);

toc;
end