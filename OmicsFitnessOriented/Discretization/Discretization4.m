%�����ݽ�����ɢ��
%�ܲ���һ����ȡһ��Ԫ�أ�����һ���Ƚϼ��ķ�������С�ڻ����ĳ��ֵ����ֱ����ΪĿ��ֵ��
integrative = load('E:\MathConstructionExercise\AttachedData\integrative.mat');
lisanData4= integrative.data4;
meanData = mean(lisanData4);%��һ�����������ܿ�����?����
stdData = std(lisanData4);

for col = 1:1080
    geban1 = meanData(col) - stdData(col);%��ֵ-����
    geban2 = meanData(col) + stdData(col);%��ֵ+����
    for row = 1:197
        if(lisanData4(row,col) < geban1)
            lisanData4(row,col) = 1;
        elseif(lisanData4(row,col) > geban2)
            lisanData4(row,col) = 3;
        else lisanData4(row,col) = 2;
        end
    end
end
path = 'E:\MathConstructionExercise\AttachedData\lisanData4.mat';
save(path,'lisanData4');
