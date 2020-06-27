clear
clc
tic
%���õĺ���������õ�S6�������'��Ҳ������ţ���������
%д��excle�к�һ�����ݷ��оͿ��Խ��������
%��������
input = load( 'E:\Data\integrative4.mat');
pts = input.data';%����5188*197
class = input.label';%ת�������о���,����
featureName = input.featureName';%ת�������о���������
%B=SubtractControl;%22810*118
%%ΪʲôҪȡǰ12�У�
% A(:,1:12) = pts(:,1:12); %ȡǰ12�У�drought ����
NumOfSamples = 3; % ��ά��Kֵ
%ת��ת�ȣ�
x=mapstd(pts',0,1)'; % ��һ������ֵΪ0�� ����Ϊ1 
K=NumOfSamples; 
type = 'standard';
sumabs= 0.9 ; 
alpha1 = 0.295;
sumabsu = alpha1 * sqrt(size(x,1));
sumabsv =  sqrt(size(x,2))*sumabs;
%pmdout=PMD(x, type,K,sumabs, sumabsu,sumabsv);  %%%% 
 pmdout=PMD(x, type,K,sumabs, sumabsu,sumabsv,[],100);  %cavell <==20101209 
 toc;
%% PCA��ʼ��
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
    %%  ѡ��ͬ����  
[selectGenes, count] = statisticOFsvd_pca(pmdout.u , spca );
%selectGenes�ĵڶ�����PMD,��������SPCA
%��������
SavePosition = 'E:\Operation\PMDandSPCA\Solution.mat';
save(SavePosition,'selectGenes');
toc  

