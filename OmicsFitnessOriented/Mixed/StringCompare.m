StandardFeature = load('E:\MathConstructionExercise\AttachedData\StandardFeature.mat');
StandardFeature3 = StandardFeature.feature3;
integrative = load('E:\MathConstructionExercise\AttachedData\integrative3.mat')
FeatureName3 = integrative.featureName3;
A = intersect(StandardFeature3,FeatureName3);
