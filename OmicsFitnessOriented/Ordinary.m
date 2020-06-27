function Ordinary(population, dimensions, iteration, experiment)
tic;
%��ͨ��΢��Ⱥ������ʵ��Ƚ�
% Ordinary(50,1,50,1)
%������Ѱ�ҽ����ȥ�ء��ȶԡ�����

%��������ѡ��ʹ��һ�׵ġ�demensions = 1;
%������Դ
Data = 'E:\MathConstructionExercise\AttachedData\integrative5.mat';
%����λ��ǰ׺SavePosition = 'E:\MathConstructionExercise\ʵ�����\';
SavePosition = ['E:\MathConstructionExercise\',num2str(experiment),'\'];
%�ȶ�������Դ
PaperProvided = 'E:\MathConstructionExercise\AttachedData\standardFeature.mat';
        
input = load(Data);
class = input.label;%����
featureName = input.featureName';%ת�������о���������

%����΢���ٶȺ�λ�õķ�Χ
pts = input.data;%����
[~, SNP_n] = size(pts);%�����У�sample�����������У�feature.�ֱ𷵻������
xmax = SNP_n; %���λ�ã�SNP������eg.100
xmin = 1;     %��Сλ��
vmax = xmax - 1;  %����ٶ�99��
vmin = - vmax;%��С�ٶ�-99��

%��ʼ����������
% shrink = 0.72989;
c1 = 2.05;
c2 = 2.05;

%���㶯̬����Ȩ��W����Ҫ�Ĳ���
a = 0.4;
b = 0.9;
n = iteration;

%����û��ʹ�ýṹ����Ƕ��Ŀǰ����֪�����ָ�����һЩ
Particle = struct('v',cell(1),'x',cell(1),...
    'mut',[],'pbest_x',cell(1),'pbest_mut',[]);
%cell(1):1*1struct

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

for iter = 1:iteration
    %����΢�����ٶ�
    for i = iter + 1:population%���ھ�
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
            Particle(i).x(j) = Particle(i).x(j) + Particle(i).v(j);
            if Particle(i).x(j) < xmin || Particle(i).x(j) > xmax
                Particle(i).x(j) = xmin + round( ( xmax  - xmin) * rand(1) );
            end 
        end
       Particle(i).mut = MutualInformation(pts, class,Particle(i).x);
    end 
    
    %����΢���ĸ�������λ��
    for i = 1:1:population
        if Particle(i).mut > Particle(i).pbest_mut
           Particle(i).pbest_mut = Particle(i).mut;
           Particle(i).pbest_x = Particle(i).x;
        end
    end
    
    %���¼�������
    [seq,id] = sort([Particle.pbest_mut],'descend');
    if(seq(1) > gbest_mut)
        gbest_mut = seq(1);
        gbest_x = Particle(id(1)).pbest_x;
    end 
 
end          

%Ѱ�����ս��������\Solution.mat(Pbest.loc,feature��'align','iM','iP')
    SolutionPath = [SavePosition,'Solution.mat'];
    FindSolution( Particle, population, featureName,SolutionPath,PaperProvided);
toc;
end
