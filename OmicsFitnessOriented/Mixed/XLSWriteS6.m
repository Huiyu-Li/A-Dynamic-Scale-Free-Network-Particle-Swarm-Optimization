%把原S6（特证名前缀但带有单引号）写进Excel
S6 = load('E:\MathConstructionExercise\AttachedData\PrimeS6.mat');
S6 = S6.S6;
xlsName = 'E:\MathConstructionExercise\AttachedData\S6.xlsx';
xlswrite(xlsName,S6);