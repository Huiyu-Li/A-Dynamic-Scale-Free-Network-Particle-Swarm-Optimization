clear;
clc;
filename = 'E:\Operation\Results.xlsx';
%% DSFPSO
Solution = load('E:\Operation\DSFPSO\Integrated\Solution.mat');
Solution = Solution.solutionFeature;
sheet = 'DSFPSO';
xlRange = 'A1';
xlswrite(filename,Solution,sheet,xlRange);
%% SIPSO
Solution = load('E:\Operation\SIPSO\Integrated\Solution.mat');
Solution = Solution.solutionFeature;
sheet = 'SIPSO';
xlRange = 'A1';
xlswrite(filename,Solution,sheet,xlRange);
%% PSO
Solution = load('E:\Operation\PSO\Integrated\Solution.mat');
Solution = Solution.solutionFeature;
sheet = 'PSO';
xlRange = 'A1';
xlswrite(filename,Solution,sheet,xlRange);