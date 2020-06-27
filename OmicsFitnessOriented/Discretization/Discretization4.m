%对数据进行离散化
%能不能一次提取一列元素，再用一个比较简便的方法，让小于或大于某个值得数直接置为目标值？
integrative = load('E:\MathConstructionExercise\AttachedData\integrative.mat');
lisanData4= integrative.data4;
meanData = mean(lisanData4);%用一个变量来接受可以吗?可以
stdData = std(lisanData4);

for col = 1:1080
    geban1 = meanData(col) - stdData(col);%均值-方差
    geban2 = meanData(col) + stdData(col);%均值+方差
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
