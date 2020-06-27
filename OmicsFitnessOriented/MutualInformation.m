function MI=MutualInformation(pts,class,factor)
% Compute Mutual Information between class label and a SNP set.
% MI(X;C)=H(X)+H(C)-H(X,C), where C is the class label and X is a SNP set.
% 5.8/2012, by Junliang Shang.
%%
data=pts(:,factor);
MI=Func_MutualInfo(double(data)',double(class));

function MI=Func_MutualInfo(data,labels)
% Jan.19 2007 By Guoqiang Yu
%
%--- INPUT
% data:  features x samples; note that the
% value of zero indicates a missing data
% labels: the label matrix of each sample; 
%
%--- OUTPUT
% MI: Information provided by the features
%%
data=data-min(data(:));          %minimum data is 0
labels=labels-min(labels(:))+1; %minimum label is 1

Num_Label=max(labels(:));
Num_DataType=max(data(:))+1;
[Num_Feature,Num_Sample]=size(data);

%Entropy of the random variable Label
H_Label=hist(labels,Num_Label);
P_Label=H_Label/Num_Sample;
Entropy_Label=-P_Label*log2(P_Label'+eps);

%Special dealing with the case of small Num_Feature
if Num_Feature<9
    A = Num_Feature-1:-1:0;
    ZZ=Num_DataType.^(Num_Feature-1:-1:0)';
    Hist_Label=zeros(Num_DataType^Num_Feature,Num_Label);%  Hist_Label is p(c,f)
    tempIndex=ZZ'*data+1;
    for j=1:Num_Sample
        Hist_Label(tempIndex(j),labels(j))=Hist_Label(tempIndex(j),labels(j))+1; % calculate p(c,f) 
    end
    
    sumHist=sum(Hist_Label,2);   %calculate p(f)
    repHist=repmat(sumHist,1,Num_Label); 
    pHist_Label=Hist_Label./(repHist+eps);%p(c/f)=p(c,f)/p(f).
    InfoIncre=-sum((log2(pHist_Label+eps).*pHist_Label).*(repHist));
    MI=Entropy_Label-sum(InfoIncre)/Num_Sample;
    return;
end

%Larger Feature Number follows the following procedure
mm=1;
Hist_Label=zeros(Num_Label,Num_Sample);
Hist_Label(labels(1,1),mm)=1;
Hist_SNP=zeros(Num_Feature,Num_Sample);
Hist_SNP(:,mm)=data(:,1);

for j=2:Num_Sample
    tempData=data(:,j);
    Index=0;
    for k=1:mm
        if isequal(Hist_SNP(:,k),tempData)
            Index=k;
            break;
        end
    end
    if Index==0
        mm=mm+1;
        Hist_SNP(:,mm)=tempData;
        Hist_Label(labels(j,1),mm)=1;
    else
        Hist_Label(labels(j,1),Index)=Hist_Label(labels(j,1),Index)+1;
    end
end

M1=mm;
InfoIncre=0;
for s=1:M1
    tempNum=sum(Hist_Label(:,s));
    P=Hist_Label(:,s)/tempNum;
    InfoIncre=InfoIncre-P'*log2(P+eps)*tempNum;
end
MI=Entropy_Label-InfoIncre/Num_Sample;