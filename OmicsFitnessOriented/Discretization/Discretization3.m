%对数据进行离散化
%能不能一次提取一列元素，再用一个比较简便的方法，让小于或大于某个值得数直接置为目标值？
integrative = load('E:\MathConstructionExercise\AttachedData\integrative.mat');
lisanData3= integrative.data3;
meanData = mean(lisanData3);%用一个变量来接受可以吗?可以
stdData = std(lisanData3);

for col = 1:2078
    geban1 = meanData(col) - stdData(col);%均值-方差
    geban2 = meanData(col) + stdData(col);%均值+方差
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
