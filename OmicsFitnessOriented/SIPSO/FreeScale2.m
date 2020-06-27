function matrix = FreeScale2(X) 
%引用网址 http://wenku.baidu.com/link?url=KqWG5UZDy1YdapSL_rm1Tf3uJPkpkkHChMYLMm9_xLo6UI2NG4T3YC8Pp_1LjEAle25lxljyZHWV_IQuL0okgBK1xx7jmVopl9ToXESij2C
N= X; m0= 4; m= 2;%初始化网络数据 
adjacent_matrix = sparse( m0, m0);% 初始化邻接矩阵 
for i = 1: m0     
    for j = 1:m0 
        if j ~= i      %去除每个点自身形成的环 
            adjacent_matrix(i,j) = 1;%建立初始邻接矩阵，每个点同均同其他的点相连         
        end
    end
end
adjacent_matrix =sparse(adjacent_matrix);%邻接矩阵稀疏化 
node_degree = zeros(1,m0+1);                %初始化点的度 
node_degree(2: m0+1) = sum(adjacent_matrix);%对度维数进行扩展 sum按列求和
for iter= (m0+1):N 
    iter;                                %加点 
    total_degree = 2*m*(iter- 4)+6;%计算网络中此点的度之和     
    cum_degree = cumsum(node_degree);%求出网络中点的度矩阵     
    choose= zeros(1,m);%初始化选择矩阵
    % 选出第一个和新点相连接的顶点 

    r1= rand(1)*total_degree;%算出与旧点相连的概率     
    for i= 1:iter-1 
        if (r1>=cum_degree(i))&( r1<cum_degree(i+1))%选取度大的点             
            choose(1) = i;             
            break         
        end
    end
    % 选出第二个和新点相连接的顶点     
    r2= rand(1)*total_degree;     
    for i= 1:iter-1 
        if (r2>=cum_degree(i))&(r2<cum_degree(i+1))             
            choose(2) = i;             
            break         
        end
    end
    while choose(2) == choose(1)%第一个点和第二个点相同的话，重新择优         
        r2= rand(1)*total_degree;         
        for i= 1:iter-1 
            if (r2>=cum_degree(i))&(r2<cum_degree(i+1))                 
                choose(2) = i;                 
                break             
            end
        end
    end
    %新点加入网络后, 对邻接矩阵进行更新     
    for k = 1:m 
        adjacent_matrix(iter,choose(k)) = 1;         
        adjacent_matrix(choose(k),iter) = 1;     
    end 
    node_degree=zeros(1,iter+1); 
    node_degree(2:iter+1) = sum(adjacent_matrix); 
end 
matrix = adjacent_matrix;