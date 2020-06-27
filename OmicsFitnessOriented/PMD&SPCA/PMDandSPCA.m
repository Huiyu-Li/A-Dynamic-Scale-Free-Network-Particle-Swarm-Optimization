clear
clc
tic
%调用的函数里面会用到S6，里面的'号也必须带着，否则会出错。
%写到excle中后一个数据分列就可以解决掉’号
%读入数据
input = load( 'E:\Data\integrative4.mat');
pts = input.data';%样本5188*197
class = input.label';%转化成了列矩阵,对照
featureName = input.featureName';%转化成了列矩阵，特征名
%B=SubtractControl;%22810*118
%%为什么要取前12列？
% A(:,1:12) = pts(:,1:12); %取前12列，drought 数据
NumOfSamples = 3; % 降维的K值
%转不转秩？
x=mapstd(pts',0,1)'; % 归一化，均值为0， 方差为1 
K=NumOfSamples; 
type = 'standard';
sumabs= 0.9 ; 
alpha1 = 0.295;
sumabsu = alpha1 * sqrt(size(x,1));
sumabsv =  sqrt(size(x,2))*sumabs;
%pmdout=PMD(x, type,K,sumabs, sumabsu,sumabsv);  %%%% 
 pmdout=PMD(x, type,K,sumabs, sumabsu,sumabsv,[],100);  %cavell <==20101209 
 toc;
%% PCA初始化
tic
A=x;
[n,p]=size(A);  %p=20; n=500   % p, number of samples; n, number of variables% A=randn(p,n);  % data matrix
A=A';
A=A-repmat((mean(A,1)),p,1);        % Centering of the data
m=NumOfSamples;                                % Number of components:
% ***** Single-unit algorithms *****
 gratio = 0.0089;%0.3789 ; % 0.27338                             % the larger, the sparser
gamma=gratio * ones(1,m);                % sparsity weight factors -one for each component - 
                                                        % in relative value with respect to the theoretical upper bound
%Z1=GPower(A,gamma,m,'l1',0);        % Sparse PCA by deflation, l1 penalty
% spca=GPower(A,gamma.^2,m,'l0',0);     % Sparse PCA by deflation, l0 penalty
spca=GPower(A,gamma.^2,m,'l1',0);  
%Y=sum(spca',1)';
% [G2]=geneselection(Y);

% Sparse PCA by deflation, l0 penalty
    %%  选择共同基因  
[selectGenes, count] = statisticOFsvd_pca(pmdout.u , spca );
%selectGenes的第二列是PMD,第三列是SPCA
%保存数据
SavePosition = 'E:\Operation\PMDandSPCA\Solution.mat';
save(SavePosition,'selectGenes');
toc  

