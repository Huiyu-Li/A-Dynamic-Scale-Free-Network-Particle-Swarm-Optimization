%% function statistic for calculating the Non-zero
%% the  sta is the nXn matrix, return the result
%% the A is the matrix, which is the member of the pmdout=PMD(x, type,K,sumabs, sumabsu,sumabsv,[],100);

function [selectGenes, count] = statisticOFsvd_pca(A, B)
    load S6;
    labelOFGenes = S6;

    [m, n] = size(A);
    count = zeros(n,2);
    selectGenes = cell(1000,n*3);
    for i = 1 : n
        k=1; r = 1; s = 1;
        for j = 1 : m

            if abs(A(j, i))>1e-6 && abs(B(j, i))> 1e-6      %% intersect
                 selectGenes(k, i*3-2) =labelOFGenes(j, 1);
                 k = k + 1;
            end
            if abs(A(j, i))>1e-6                            %% absolute value of A (PMD) larger than 1e-6
                count(i,1) = count(i,1)+1;
                selectGenes(r, i * 3 -1) =labelOFGenes(j, 1);
                r = r+1;
            end
            if abs(B(j, i))>1e-6                            %% absolute value of B (SPCA) larger than 1e-6
                count(i,2) = count(i,2)+1;
                selectGenes(s, i * 3 ) =labelOFGenes(j, 1);
                s = s+1;              
            end
            
            
         end
    end            

%       %% the following obtains the three fators.  
%       
%      for i = 1 : n
%         for j = 1 : n
%             for r = 1 : n
%                 for k = 1 : m
%                     if abs(A(k, i))>0.001 && abs(A(k, j))>0.001   && abs(A(k, r))>0.001...
%                     %%        && ~( i==j || i == r || r ==j)
%                         sta3(i, j, r) = sta3(i, j, r) + 1;
%                     end
%                 end
%             end
%         end   
% end
