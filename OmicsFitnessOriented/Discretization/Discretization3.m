%�����ݽ�����ɢ��
%�ܲ���һ����ȡһ��Ԫ�أ�����һ���Ƚϼ��ķ�������С�ڻ����ĳ��ֵ����ֱ����ΪĿ��ֵ��
integrative = load('E:\MathConstructionExercise\AttachedData\integrative.mat');
lisanData3= integrative.data3;
meanData = mean(lisanData3);%��һ�����������ܿ�����?����
stdData = std(lisanData3);

for col = 1:2078
    geban1 = meanData(col) - stdData(col);%��ֵ-����
    geban2 = meanData(col) + stdData(col);%��ֵ+����
    for row = 1:197
        if(lisanData3(row,col) < geban1)
            lisanData3(row,col) = 1;
        elseif(lisanData3(row,col) > geban2)
            lisanData3(row,col) = 3;
        else lisanData3(row,col) = 2;
        end
    end
end
path = 'E:\MathConstructionExercise\AttachedData\lisanData3.mat';
save(path,'lisanData3');
