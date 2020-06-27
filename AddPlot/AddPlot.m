function Solution = AddPlot(population, dimensions, iteration, data)
tic;
%   AddPlot(50,2,50,'E:\MathConstructionExercise\AttachedData\dat100.mat')
%һ������Ҳû���ˣ�����

%��fitnessOriented�Ļ����ϣ������ʽ���Ż����Ժ���ģ�黯���룩
%�����(AddPlot-InitializedTracking-Tracking-SolutionLabel|ConciseSLabel )

%������-���ݱ��棬�Ӻ���-������ȡ����ס����ֲ������޸�
%����λ��ǰ׺  E:\MathConstructionExercise\Operation\AddPlotOperation\ +�Լ�������
SavePosition = 'E:\MathConstructionExercise\1';
%����ļ����ڻᱻ��д

%��ʼ����ʼ
    %����΢���ٶȺ�λ�õķ�Χ
    input = load(data);
    pts = input.pts;%����
    class = input.class;%����
    [~, SNP_n] = size(pts);%�����У�sample�����������У�SNP.�ֱ𷵻������
    xmax = SNP_n; %���λ�ã�SNP������eg.100
    xmin = 1;     %��Сλ��
    vmax = xmax - 1;  %����ٶ�99��
    vmin = - vmax;%��С�ٶ�-99��

    %��ʼ����������
    shrink = 0.72989;
    c1 = 2.05;
    c2 = 2.05;
    %���㶯̬����Ȩ��W����Ҫ�Ĳ���
    a = 0.4;
    b = 0.9;
	n = iteration;
    %����û��ʹ�ýṹ����Ƕ��Ŀǰ����֪�����ָ�����һЩ
    Particle = struct('v',cell(1),...
                      'x',cell(1), 'mut',[],...
                      'pbest_x',cell(1),'pbest_mut',[],...
                      'nbest_x',cell(1),'nbest_mut',[]);
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
            Particle(i).x(j) = round(1 + rand(1) * (xmax - 1) );
            %�������ȡ��1�ģ�Ҳ��ȡ��100��
        end
       Particle(i).mut = MutualInformation(pts, class,Particle(i).x);%������Ӧ��
    end
    
    %��ʼ��΢���ĸ�������λ�ã�����΢���ĳ�ʼ��λ��
    [Particle.pbest_x] = Particle.x;
    [Particle.pbest_mut] = Particle.mut;
    
    %��ʼ��΢���������ھ�λ��,����ó�ʼ�����������ĳ��θ�ֵ��ʧ�ܵ�
     %[Particle.nbest_x] = deal([0,0]);%ֻ��һ��ֵҲû��ϵ
     [Particle.nbest_mut] = deal(0);%ֻ��mut��ֵΪ��ֵ����Ϊλ�ø�ֵΪ0��bug
     
    %��ʼ��΢���ļ�������λ��(ֻ��һ�����Ӹ�����ʷ��������)
    [seq,id] = sort([Particle.pbest_mut],'descend');
    gbest_mut = seq(1);
    gbest_x = Particle(id(1)).pbest_x;
    
    %��ʼ���ޱ������ͼ
    m0 = 2;m = 2;
    % ��ʼ���ڽӾ�����ȫ��ͨ
    adjacent_matrix = ones( m0, m0);
    for i = 1:m0
        adjacent_matrix(i,i) = 0;
    end
    
    %��[m0 + 1,;population]��ѡ��ǰ��Ӧ����ߵ�������,�����Ͳ��ô�����������
    [~,id] = sort([Particle(m0 + 1:population).mut],'descend');%[m0 + 1:population]ȥ���˷����ţ���֪���Բ��ԣ�
    id = id + m0;
    %��ѡ�е���������ǰ��������λ�ã������Ӧ�Ȳ�ͬ�Ļ���
    for i = 1:m0
        if(Particle(id(i)).mut ~= Particle(i).mut)
            %�϶�����û�н����ģ�Ӧ��ûʲôӰ��ɣ���ʹû�н���������Ϊ�˼�Ҳ����Ӧ����ߵ����Բ��ý���
            temp = Particle(id(i));
            Particle(id(i)) = Particle(i);
            Particle(i) = temp;
        end
    end
    %���ˣ���ʣpopulation - m0������Ҫ����
%��ʼ������

% %���ٻ�ͼ-��ʼ������,����һ����ʼ�����ٶ��õĺ���
%     InitializedTracking( Particle, population, adjacent_matrix, gbest_x );
%     %�����ͼ
%     name = [SavePosition '1InitializeTracking.png'];
%     saveas(gcf,name);%OK!
    
%������ͼ
    for iter = (m0+1):population
        
        %�ӵ�
        %��[iter,population]��ѡ��ǰ��Ӧ����ߵ�һ��΢����Ϊ��ͼ΢��
        [~,id] = sort([Particle( iter:population ).mut],'descend');
        id = id + (iter - 1);%ע��id�Ǵ�1��ʼ��,����(iter - 1)֮��ź�Particle�е��±����Ӧ
        %����ͼ΢����iterλ�õ�΢��������ԭ�����ǲ�ͬ��ʱ��Ž�����
        if(Particle(id(1)).mut ~= Particle(iter).mut)
            temp = Particle(id(1));
            Particle(id(1)) = Particle(iter);
            Particle(iter) = temp;
        end
        
        %��[1��iter - 1]��ѡ��ǰ��Ӧ����ߵ�����΢����Ϊ�ھ�
        %��ʵ����ͦ�õģ��������ص�����
        [~,id] = sort([Particle( 1:iter - 1 ).mut],'descend'); 
        choose( 1:m )= id( 1:m );%��ʼ��ѡ�����
        %�����ҵ�ǰ��Ӧ����ߵ�΢�����Ƿ�����������ֲ����ţ�
        %������ȥ�ж��ǲ��������˾ֲ������أ��ܲ�����ͼֱ�۵ؿ�һ�£�
        
        %���ڽӾ�����м����±ߣ��ڽӾ�����һ��һ������ġ�     
        for k = 1:m 
            adjacent_matrix(iter,choose(k)) = 1;         
            adjacent_matrix(choose(k),iter) = 1;     
        end 
        
        %����΢�����ٶ�
        %���ھ��ü�������|���ھ����ھӵĸ�����ʷ����
        %��ͼʱ��<=iter�����ھ�
        for i = 1:iter%���ھ�
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
        
        %����΢���������ھ�λ�ã��������ھӵ���˵��
        for i = 1:1:iter
             nbr = find(adjacent_matrix(i,:) == 1);
            for j = 1:1:numel(nbr)
                if Particle(nbr(j)).pbest_mut > Particle(i).nbest_mut
                    Particle(i).nbest_mut = Particle(nbr(j)).pbest_mut;
                    Particle(i).nbest_x = Particle(nbr(j)).pbest_x;
                end
            end
        end
        
        %���¼�������
        [seq,id] = sort([Particle.pbest_mut],'descend');
        if(seq(1) > gbest_mut)
            gbest_mut = seq(1);
            gbest_x = Particle(id(1)).pbest_x;
        end   
        
%���ٻ�ͼ-��ͼ����
    %ͼʾ����ͼ��΢���������Ӧ
    %���ÿ�ָ���ֻ��һ��ͼ���ͰѺ����������ŵ�end����
     LunWenTracking( Particle, adjacent_matrix,population);
%     Tracking( Particle, population, adjacent_matrix, gbest_x, '��ͼ����',iter );
    %�����ͼ
    gname = [SavePosition 'DrawingTraking',num2str(iter),'.png'];%OK!
    saveas(gcf,gname);
    
%     %ͼʾ�ͽ�ͼ�������������Ӧ
%     Tracking( Particle, population, adjacent_matrix, gbest_x, '��ͼ����',iter );

    end          
%��ͼ���

%Ѱ���м���������
    SolutionN = 5;%Ѱ��ǰ����������
    Pbest_mut_sorted_name = 'IntermediatePbest_mut_sorted.mat';
    Pbest_x_sorted_name = 'IntermediatePbest_x_sorted.mat';
    Solution_name = 'IntermediateS.mat';
    IntermediateS = FindSolution( Particle, population, SolutionN, SavePosition,...
    Pbest_mut_sorted_name, Pbest_x_sorted_name, Solution_name);

%�м�����ͼ������
    DrawingName = '�м�������';
    DetailedSLabel_name = 'IntermediateDetailedSLabel.png'; 
    ConciseSLabel_name = 'IntermediateConciseSLabel.png';
    DrawingSolutin( Particle, population, adjacent_matrix, gbest_x, IntermediateS, DrawingName,...
    SavePosition, DetailedSLabel_name, ConciseSLabel_name);


%��ʼ��ͼ��ĵ���
    D = sum(adjacent_matrix);%΢������Ⱦ���
    for iter = 1:1:iteration
        
        %����΢�����ٶ�
        for i = 1:1:population
            if D(i) <= 5 %K��ʾ΢������ȣ��о���
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
        
        %����΢�����ھ�����λ��
        for i = 1:1:population
            nbr = find(adjacent_matrix(i,:) == 1);
            for j = 1:1:numel(nbr)
                if  Particle(nbr(j)).pbest_mut > Particle(i).nbest_mut
                    Particle(i).nbest_mut = Particle(nbr(j)).pbest_mut;
                    Particle(i).nbest_x = Particle(nbr(j)).pbest_x;
                end
            end
        end
        
        %���¼�������(����Ϊ�˻�ͼ����ӵģ�ʵ������ʱ��Ϊͼ�Ѿ����꣬�ʲ�����pbest�����ٶ���)
        [seq,id] = sort([Particle.pbest_mut],'descend');
        if(seq(1) > gbest_mut)
            gbest_mut = seq(1);
            gbest_x = Particle(id(1)).pbest_x;
        end           
        
%���ٻ�ͼ-��ͼ�����
    %���ÿ�ָ���ֻ��һ��ͼ���ͰѺ����������ŵ�end����
    Tracking( Particle, population, adjacent_matrix, gbest_x, '��������',iter );
    %�����ͼ
    gname = [SavePosition 'IterationTraking',num2str(iter),'.png'];%OK!
    saveas(gcf,gname);
    
    end          
%��������

%Ѱ�����ս��������
    SolutionN = 5;%Ѱ��ǰ����������
    Pbest_mut_sorted_name = 'SolutionPbest_mut_sorted.mat';
    Pbest_x_sorted_name = 'SolutionPbest_x_sorted.mat';
    Solution_name = 'Solution.mat';
    Solution = FindSolution( Particle, population, SolutionN, SavePosition,...
    Pbest_mut_sorted_name, Pbest_x_sorted_name, Solution_name);

%�м�����ͼ������
    %��������Ϊ�˿����꾡��ȫ�̣��������˶�pbest�ĸ��£�
    %���ԣ��������ǿ���ͳһ��ͼ������
    DrawingName = '���ս������';
    DetailedSLabel_name = 'SolutionDetailedSLabel.png'; 
    ConciseSLabel_name = 'SolutionConciseSLabel.png';
    DrawingSolutin( Particle, population, adjacent_matrix, gbest_x, IntermediateS, DrawingName,...
    SavePosition, DetailedSLabel_name, ConciseSLabel_name);
  toc;%��λ���룬/60�Ƿ��� 
  %ʱ���ѹ� 1138.250616 �롣 = 18.9708436����
  
end